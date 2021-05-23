module "argocd" {
  source                    = "/terraform/modules/argocd"
  argocd_version            = "3.5.0"
  argo_global_image_tag     = "v2.0.1-arm"
  cluster_name              = "default"
  argocd_hostname           = "argocd.wolfe.int"
  github_username           = data.vault_generic_secret.github.data["username"]
  github_token              = data.vault_generic_secret.github.data["token"]
  github_oauth_clientID     = data.vault_generic_secret.oauth.data["ClientID"]
  github_oauth_clientSecret = data.vault_generic_secret.oauth.data["ClientSecret"]
  argocd_admin_groups       = ["admin"]
  cluster_bootstrap_repo    = "https://github.com/stephenwolfe1/homelab.git"
}
