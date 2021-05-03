resource "random_id" "gossip_key" {
  byte_length = 16
}

resource "kubernetes_namespace" "consul" {
  metadata {
    name        = "consul"
    annotations = local.standard_tags
  }
}

resource "kubernetes_secret" "example" {
  metadata {
    name        = "consul-gossip-encryption-key"
    namespace   = "consul"
    annotations = local.standard_tags
  }

  data = {
    "key" = random_id.gossip_key.id
  }
}
