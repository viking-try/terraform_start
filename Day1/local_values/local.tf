terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::766754604623:role/terrraform-role"
    session_name = "terraform_dey1"
    external_id  = "terraform.test"
  }
}

locals {
  my_tags={
      owner="me"
      code="1234"
  }
}

resource "aws_instance" "name" {
    ami = "ami-0f9fc25dd2506cf6d"
    instance_type = "t2.nano"
    tags=local.my_tags
}