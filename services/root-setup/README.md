# root-setup terraform service

This service creates the AWS resources for Terraform to run
* Needs initial root credentials to bootstrap S3, IAM, Dynamo
* Delete root credentials after setup
* State stored locally and manually backed up to S3 after created

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.37.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | = 3.37.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.terraform_state_lock](https://registry.terraform.io/providers/hashicorp/aws/3.37.0/docs/resources/dynamodb_table) | resource |
| [aws_iam_user.terraform_user](https://registry.terraform.io/providers/hashicorp/aws/3.37.0/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.terraform_user_policy](https://registry.terraform.io/providers/hashicorp/aws/3.37.0/docs/resources/iam_user_policy) | resource |
| [aws_s3_bucket.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/3.37.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/3.37.0/docs/resources/s3_bucket_policy) | resource |
| [aws_iam_policy_document.terraform_policy](https://registry.terraform.io/providers/hashicorp/aws/3.37.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/3.37.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | AWS region for resources | `string` | `"us-west-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | ARN of S3 bucket for terraform.state storage |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | Name of S3 bucket for terraform.state storage |
| <a name="output_dynamodb_arn"></a> [dynamodb\_arn](#output\_dynamodb\_arn) | ARN of Dynamodb for terraform.state locking |
| <a name="output_dynamodb_name"></a> [dynamodb\_name](#output\_dynamodb\_name) | Name of Dynamodb for terraform.state locking |
