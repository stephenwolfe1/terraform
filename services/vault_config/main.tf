/**
* # vault_config setups vault auth and general configuration
*
*/

terraform {
  backend "s3" {
    bucket         = "spw006-terraform.tfstate"
    dynamodb_table = "terraform.tfstate.lock"
    encrypt        = true
    key            = "services/vault_config/terraform.tfstate"
    region         = "us-west-2"
  }
}

locals {
  standard_tags = {
    terraform_managed = "true"
    defined_in        = "${replace(abspath(path.module), "//terraform//", "")}"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "vault" {}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
