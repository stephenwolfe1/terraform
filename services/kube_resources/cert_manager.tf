//Cloudflare secret for cert-manager issuer
data "vault_generic_secret" "cloudflare" {
  path = "manual/cloudflare/credentials"
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name        = "cert-manager"
  }
}

resource "kubernetes_secret" "cert_manager" {
  metadata {
    name        = "cloudflare-api-token-secret"
    namespace   = "cert-manager"
  }

  data = {
    "api-token" = data.vault_generic_secret.cloudflare.data["api-token"]
  }
}