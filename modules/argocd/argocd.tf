resource "random_password" "argocd_admin_password" {
  length = 24
}

resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_version

  set {
    name  = "global.image.tag"
    value = var.argo_global_image_tag
    type  = "string"
  }

  values = [
    templatefile("${path.module}/templates/values.yaml",
      {
        github_oauth_clientID     = var.github_oauth_clientID
        github_oauth_clientSecret = var.github_oauth_clientSecret
        github_username           = var.github_username
        hostname                  = var.argocd_hostname
        argocd_admin_groups       = var.argocd_admin_groups
    })
  ]

  set_sensitive {
    name  = "configs.secret.argocdServerAdminPassword"
    value = bcrypt(random_password.argocd_admin_password.result)
  }

  lifecycle {
    ignore_changes = [set_sensitive]
  }
}

# Config Helm Install
resource "helm_release" "argocd_config" {
  depends_on  = [helm_release.argocd]
  name        = "argocd-config"
  namespace   = "argocd"
  repository  = "https://argoproj.github.io/argo-helm"
  chart       = "argocd-apps"
  version     = var.argocd_config_version
  max_history = 1

  values = [
    templatefile("${path.module}/templates/values_config.yaml",
      {
        cluster_name           = var.cluster_name
        cluster_bootstrap_repo = var.cluster_bootstrap_repo
        target_revision        = var.target_revision
    })
  ]
}