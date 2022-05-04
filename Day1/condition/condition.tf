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

resource "aws_instance" "dev" {
  instance_type = "t2.nano"
  ami = "ami-0f9fc25dd2506cf6d"
  count = var.isdev ? 1 : 0
  #for false count is 0 thats why this resouce will not be created if condition fails 
}

resource "aws_instance" "prod" {
  instance_type = "t2.nano"
  ami = "ami-0f9fc25dd2506cf6d"
  # condition exp syntex = condition ? value_when_true : value_when_false
  # we use == to compair like other langs
  count = var.isdev == false ? 2 : 0 
  # or since isdev is already a bool you can use it like below too 
  #count = var.isdev ? 0 : 2 #this will set count to 2 if isdev is flase 

}



