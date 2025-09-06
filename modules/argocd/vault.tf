resource "vault_generic_secret" "vault_output" {
  path = "terraform/argocd/credentials"

  data_json = jsonencode(
    {
      "username" = "admin",
      "password" = "${random_password.argocd_admin_password.result}"
    },
  )
}
