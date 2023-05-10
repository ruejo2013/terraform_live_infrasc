
# s3 and dynamodb output variables
output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state_s3.arn 
  description = "The ARN of the s3 bucket"
}


output "dynamodb_table_name" {
  value        = aws_dynamodb_table.terraform_stfile_dynamo_tbl.name
  description  = "The Dynamodb table name"
}