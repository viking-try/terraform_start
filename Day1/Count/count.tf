terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

variable "env" {
    type = list
    default = ["dev","stage"]
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::766754604623:role/terrraform-role"
    session_name = "terraform_dey1"
    external_id  = "terraform.test"
  }
}

resource "aws_instance" "webServ" {
  instance_type = "t2.micro"
  ami = "ami-0f9fc25dd2506cf6d"
  count = 2
  tags = {
    "count" = "${var.env[count.index]}_power"
  }
}



