output "bucket_name" {
  description = "Name of S3 bucket for terraform.state storage"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "bucket_arn" {
  description = "ARN of S3 bucket for terraform.state storage"
  value       = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_name" {
  description = "Name of Dynamodb for terraform.state locking"
  value       = aws_dynamodb_table.terraform_state_lock.name
}

output "dynamodb_arn" {
  description = "ARN of Dynamodb for terraform.state locking"
  value       = aws_dynamodb_table.terraform_state_lock.arn
}
