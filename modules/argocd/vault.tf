resource "vault_generic_secret" "vault_output" {
  path = "terraform/argocd/${var.cluster_name}"

  data_json = jsonencode(
    {
      "admin_password" = "${random_password.argocd_admin_password.result}"
    },
  )
}
