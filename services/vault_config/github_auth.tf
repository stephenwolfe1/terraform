resource "vault_github_auth_backend" "main" {
  organization = "stephenpwolfe"
}

resource "vault_github_team" "svc" {
  backend  = vault_github_auth_backend.main.id
  team     = "service_accounts"
  policies = ["service_accounts"]
}

resource "vault_github_team" "admin" {
  backend  = vault_github_auth_backend.main.id
  team     = "admins"
  policies = ["admin"]
}
