provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.2.0.0/16"
  
  tags = {
    Name = "main"
  }
}
