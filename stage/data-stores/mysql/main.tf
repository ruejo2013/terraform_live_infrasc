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

resource "aws_db_instance" "mysql_db" {
    identifier_prefix       = "terraform-playground-db"
    engine                  = "mysql"
    allocated_storage       = 10
    instance_class          = "db.t2.micro"
    skip_final_snapshot     = true
    db_name                 = "terraform_database"

    # how should we set the username and password
    username                = var.db_username
    password                = var.db_password
}


terraform {
  backend "s3" {
    bucket  = "mena-terraform-up-and-running-bucket"
    key     = "stage/data-stores/mysql/terraform.tfstate"
    region  = "us-east-1"

    dynamodb_table = "terraform_dynamo_tf_stfile_lock"
    encrypt        = true
  }
}