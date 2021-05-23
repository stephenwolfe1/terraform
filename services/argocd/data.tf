data "vault_generic_secret" "oauth" {
  path = "manual/github/oauth/argocd"
}

data "vault_generic_secret" "github" {
  path = "manual/github/credentials"
}
