# creating an s3 bucket
terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

## create backend 
# terraform {
#   backend "s3" {
#     key     = "global/s3/terraform.tfstate"
#   }
# }

resource "aws_s3_bucket" "terraform_state_s3" {
  bucket = "mena-terraform-up-and-running-bucket"

  # prevent accidental deletion of this bucket
  # lifecycle {
  #   prevent_destroy = false
  # }
}

# ## enable s3 versioning
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state_s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

# ## enable server side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.terraform_state_s3.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# # block public access to s3
resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket                  = aws_s3_bucket.terraform_state_s3.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

## create dynamo db to lock the state file
resource "aws_dynamodb_table" "terraform_stfile_dynamo_tbl" {
  name          = "terraform_dynamo_tf_stfile_lock"
  billing_mode  = "PAY_PER_REQUEST"
  hash_key      = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

