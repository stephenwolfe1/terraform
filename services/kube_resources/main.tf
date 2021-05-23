/**
* # kube_resources setups secrets and config data for various kubernetes services
*
*/

terraform {
  backend "s3" {
    bucket  = "spw006-terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
    key     = "services/kube_resources/terraform.tfstate"
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
