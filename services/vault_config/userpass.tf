resource "vault_auth_backend" "userpass" {
  type = "userpass"
  path = "userpass"
}

/*
provider panic
resource "vault_mfa_duo" "my_duo" {
  name            = "my_duo"
  mount_accessor  = vault_auth_backend.userpass.accessor
  secret_key      = "var.secret_key"
  integration_key = "var.integration_key"
  api_hostname    = "var.api_hostname"
}
*/
