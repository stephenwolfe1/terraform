/**
* # Installs Argocd and configures bootstrap application
*
*/

terraform {
  backend "s3" {
    bucket         = "spw006-terraform.tfstate"
    dynamodb_table = "terraform.tfstate.lock"
    encrypt        = true
    key            = "services/argocd/terraform.tfstate"
    region         = "us-west-2"
  }
}