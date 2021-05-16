resource "vault_mount" "kubernetes" {
  path        = "kubernetes"
  type        = "kv"
  description = "Kubernetes secrets mount"

  options = {
    version = 2
  }
}

resource "vault_generic_endpoint" "kubernetes" {
  depends_on           = [vault_mount.kubernetes]
  path                 = "${vault_mount.kubernetes.path}/config"
  ignore_absent_fields = true
  disable_delete       = true

  data_json = jsonencode({
    max_versions = 5
  })
}

resource "vault_mount" "tf" {
  path        = "terraform"
  type        = "kv"
  description = "Terraform secrets mount"

  options = {
    version = 2
  }
}

resource "vault_generic_endpoint" "tf" {
  depends_on           = [vault_mount.tf]
  path                 = "${vault_mount.tf.path}/config"
  ignore_absent_fields = true
  disable_delete       = true

  data_json = jsonencode({
    max_versions = 5
  })
}

resource "vault_mount" "manual" {
  path        = "manual"
  type        = "kv"
  description = "Manual secrets mount"

  options = {
    version = 2
  }
}

resource "vault_generic_endpoint" "manual" {
  depends_on           = [vault_mount.manual]
  path                 = "${vault_mount.manual.path}/config"
  ignore_absent_fields = true
  disable_delete       = true

  data_json = jsonencode({
    max_versions = 5
  })
}
