/**
* # Installs Argocd and configures bootstrap application
*
*/

terraform {
  backend "s3" {
    bucket  = "spw006-terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
    key     = "services/argocd/terraform.tfstate"
  }
}

locals {
  standard_tags = {
    terraform_managed = "true"
    defined_in        = "${replace(abspath(path.module), "//terraform//", "")}"
  }
}

provider "vault" {}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
