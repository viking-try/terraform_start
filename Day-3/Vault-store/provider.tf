variable "role" {
  default = "empty"
  #getting role arn from tfvars
}
terraform {
  backend "s3" {
    bucket = "terraform-backend-mkn"
    key    = "prod/vault2S"
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


provider "vault" {
  address = "http://127.0.0.1:8200"
}

data "vault_generic_secret" "dbsec" {
  path = "secret/db_creds"

}
output "dbcred" {
  value = data.vault_generic_secret.dbsec.data_json
  sensitive = true
  
}

resource "aws_eip" "name" {
  vpc = true
  provisioner "local-exec" {
    command = "echo ${data.vault_generic_secret.dbsec.data_json} >> test.logs"

  }
  
}

