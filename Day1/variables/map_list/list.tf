variable "list_of_ec2Types" {
    type = list
    default = ["t2.micro", "t2.nano"]
  
}

resource "aws_instance" "webServ2" {
  instance_type = var.list_of_ec2Types[0]
  #var.listname[position_in_list] 
  ami = "ami-0f9fc25dd2506cf6d"
}