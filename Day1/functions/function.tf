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
  time=formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

variable "nameL" {
    type = list
    default = ["firstec2", "secondec2"]
  
}

variable "region" {
    default = "ap-south1"
}

variable "amiMap" {
    type = map 
    default = {
        "ap-south1" = "ami-0f9fc25dd2506cf6d"
        "pro" = "ami-0f9fc25dd2506cf6p"
        entry = "ami-0f9fc25dd2506cf6e"
    }
  #key name can be without ""
}

resource "aws_key_pair" "ssh_key_web" {
    key_name = "mydey"
    public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_instance" "name2" {
    ami = lookup(var.amiMap, var.region)
    instance_type = "t2.micro"
    key_name = aws_key_pair.ssh_key_web.key_name
    count = 2
    tags = {
        "name" = element(var.nameL,count.index)
        #"name" = var.nameL[count.index]
    }
}

output "timet" {
    value = local.time

}