/**
* # kube_resources setups secrets and config data for various kubernetes services
*
*/

terraform {
  backend "s3" {
    bucket         = "spw006-terraform.tfstate"
    dynamodb_table = "terraform.tfstate.lock"
    encrypt        = true
    key            = "services/kube_resources/terraform.tfstate"
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
