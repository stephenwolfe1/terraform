// Read from environment variables if vault doesn't exist yet 
locals {
  github_username           = var.github_username == "" ? data.vault_generic_secret.github.data["username"] : var.github_username
  github_token              = var.github_token == "" ? data.vault_generic_secret.github.data["token"] : var.github_token
  github_oauth_clientID     = var.github_oauth_clientID == "" ? data.vault_generic_secret.oauth.data["ClientID"] : var.github_oauth_clientID
  github_oauth_clientSecret = var.github_oauth_clientSecret == "" ? data.vault_generic_secret.oauth.data["ClientSecret"] : var.github_oauth_clientSecret
  standard_tags = {
  terraform_managed = "true"
  defined_in        = "${replace(abspath(path.module), "//terraform//", "")}"
  }
}
