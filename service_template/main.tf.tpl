/**
* # Creates resources for $SERVICE
*
*/

terraform {
  backend "s3" {
    bucket         = "$STATE_BUCKET"
    dynamodb_table = "$LOCK_TABLE"
    encrypt        = true
    key            = "services/$SERVICE/terraform.tfstate"
    region         = "$REGION"
  }
}

locals {
  standard_tags = {
    terraform_managed = "true"
    defined_in        = "${replace(abspath(path.module), "//terraform//", "")}"
  }
}
