variable "role" {
  default = "empty"
  #getting role arn from tfvars
}
terraform {
  backend "s3" {
    bucket = "terraform-backend-mkn"
    key    = "prod"
    region = "us-east-1"
    role_arn     = "arn:aws:iam::766754604623:role/terrraform-role"
    session_name = "terraform_dey1"
    external_id  = "terraform.test"
  }
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
    role_arn     = var.role
    session_name = "terraform_dey1"
    external_id  = "terraform.test"
  }
}

resource "aws_security_group" "testsec" {
  name = "allow list2"
  ingress {
    description = "all 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "all 443"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}