data "vault_policy_document" "svc" {
  rule {
    path         = "auth/eks*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "Allow terraform to manage kubernetes auth config"
  }

  rule {
    path         = "sys/auth"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "Allow terraform to manage kubernetes auth config"
  }

  rule {
    path         = "sys/auth/eks*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "Allow terraform to manage kubernetes auth config"
  }

  rule {
    path         = "sys/policies/acl/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "Allow terraform to manage kubernetes auth policies"
  }

  rule {
    path         = "auth/token/create"
    capabilities = ["create", "read", "update", "list"]
    description  = "Grant ability to generate tokens from self"
  }

  rule {
    path         = "auth/token/lookup-accessor"
    capabilities = ["create", "read", "update", "list"]
    description  = "Grant ability to lookup token by accessor needed for terraform resources"
  }

  rule {
    path         = "auth/token/revoke-accessor"
    capabilities = ["create", "read", "update", "list"]
    description  = "Grant ability to revoke token by accessor needed for terraform resources"
  }

  rule {
    path         = "kubernetes/data/*"
    capabilities = ["create", "update", "delete", "read", "list", "sudo"]
    description  = "Allow Service Account Read-Write Access on kubernetes/"
  }

  rule {
    path         = "kubernetes/delete/*"
    capabilities = ["update"]
    description  = "Allow Service Account simple delete on kubernetes/"
  }

  rule {
    path         = "kubernetes/undelete/*"
    capabilities = ["update"]
    description  = "Allow Service Account simple undelete on kubernetes/"
  }

  rule {
    path         = "kubernetes/metadata/*"
    capabilities = ["read", "list"]
    description  = "Allow Service Account version browsing on kubernetes/"
  }

  rule {
    path         = "terraform/data/*"
    capabilities = ["create", "update", "delete", "read", "list", "sudo"]
    description  = "Allow Service Account Read-Write Access on terraform/"
  }

  rule {
    path         = "terraform/delete/*"
    capabilities = ["update"]
    description  = "Allow Service Account simple delete on terraform/"
  }

  rule {
    path         = "terraform/undelete/*"
    capabilities = ["update"]
    description  = "Allow Service Account simple undelete on terraform/"
  }

  rule {
    path         = "terraform/metadata/*"
    capabilities = ["read", "list"]
    description  = "Allow Service Account version browsing on terraform/"
  }

  rule {
    path         = "manual/*"
    capabilities = ["read", "list"]
    description  = "Allow Service Account Read-Only Access to manual/*"
  }
}

resource "vault_policy" "svc" {
  name   = "service_accounts"
  policy = data.vault_policy_document.svc.hcl
}

data "vault_policy_document" "admin" {
  rule {
    path         = "*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "Policy used for admin"
  }
}

resource "vault_policy" "admin" {
  name   = "admin"
  policy = data.vault_policy_document.admin.hcl
}
