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

data "aws_ami" "regionami_id" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }
}

resource "aws_instance" "webServ" {
  instance_type = "t2.micro"
  ami = data.aws_ami.regionami_id.id
}

output "ami_d" {
    value = data.aws_ami.regionami_id
  
}
