/**
* # root-setup terraform service
*
* This service creates the AWS resources for Terraform to run
* * Needs initial root credentials to bootstrap S3, IAM, Dynamo
* * Delete root credentials after setup
* * State stored locally and manually backed up to S3 after created
*
*/

terraform {
  backend "local" {
    path = "/terraform/.terraform.tfstate/services/root-setup/terraform.tfstate"
  }
}

provider "aws" {
  region  = var.region
  profile = "root"
}

locals {
  standard_tags = {
    terraform_managed = "true"
    defined_in        = "${replace(abspath(path.module), "//terraform//", "")}"
  }
}
