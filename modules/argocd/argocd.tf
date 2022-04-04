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
        global_image_tag          = var.argo_global_image_tag
        dex_image_tag             = var.dex_image_tag
        argocd_admin_groups       = var.argocd_admin_groups
        cluster_bootstrap_repo    = var.cluster_bootstrap_repo
        cluster_name              = var.cluster_name
        enable_argo_sso           = var.enable_argo_sso
        environment               = var.environment
        github_oauth_clientID     = var.github_oauth_clientID
        github_oauth_clientSecret = var.github_oauth_clientSecret
        github_token              = var.github_token
        github_username           = var.github_username
        hostname                  = var.argocd_hostname
        repo_server_min_replicas  = var.repo_server_min_replicas
        repo_server_max_replicas  = var.repo_server_max_replicas
        target_revision           = var.target_revision
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
