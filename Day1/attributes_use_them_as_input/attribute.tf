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

resource "aws_eip" "pubip" {
    vpc = true
}

output "pubip" {
    value = aws_eip.pubip
}

resource "aws_instance" "webServ" {
  instance_type = "t2.micro"
  ami = "ami-0f9fc25dd2506cf6d"
}

#here we are refrencing both resource blocks that were created 
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.webServ.id
  allocation_id = aws_eip.pubip.id
}

resource "aws_security_group" "allow_tls" {
  name        = "eipAllow"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from eip"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.pubip.public_ip}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}