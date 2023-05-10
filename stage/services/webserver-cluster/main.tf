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

module "webcserver_cluster" {
  source = "git@github.com:ruejo2013/terraform_modules.git//services/webserver-cluster?ref=v0.0.2"

  cluster_name        = "webserver-staging"
  db_remote_bucket    = "mena-terraform-up-and-running-bucket"
  db_rmote_state_key  = "stage/data-stores/mysql/terraform.tfstate"

  instance_type       = "t2.micro"
  min_size            = 2
  max_size            = 2
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type            = "ingress"
  security_group_id  = module.webcserver_cluster.alb_security_group_id
  from_port     = 12345
  to_port       = 12345
  protocol      = "tcp"
  cidr_blocks   = ["0.0.0.0/0"]
}