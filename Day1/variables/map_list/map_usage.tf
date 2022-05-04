terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
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

variable "map_of_region" {
    type = map
    default = {
        us-est1="t2.micro"
        us-est1a="t2.nano"
    }
  
}

resource "aws_instance" "webServ" {
  instance_type = var.map_of_region.us-est1
  #var.map_name.key_name 
  ami = "ami-0f9fc25dd2506cf6d"
}