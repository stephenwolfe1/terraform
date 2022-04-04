module "argocd" {
  source                    = "/terraform/modules/argocd"
  argocd_version            = "3.5.0"
  argo_global_image_tag     = "v2.0.1-arm"
  cluster_name              = "default"
  argocd_hostname           = "argocd.wolfe.int"
  argocd_admin_groups       = ["admins"]
  cluster_bootstrap_repo    = "https://github.com/stephenwolfe1/argocd-applications.git"
  target_revision           = "setup"
  github_username           = local.github_username
  github_token              = local.github_token
  github_oauth_clientID     = local.github_oauth_clientID
  github_oauth_clientSecret = local.github_oauth_clientSecret
}
