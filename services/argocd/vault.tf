resource "vault_generic_secret" "vault_output" {
  path = "terraform/argocd/credentials"

  data_json = jsonencode(
    {
      "username" = "admin",
      "password" = "${module.argocd.admin_password}"
    },
  )
}
