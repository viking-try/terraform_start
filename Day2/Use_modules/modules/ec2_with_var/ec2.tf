resource "aws_instance" "webServ" {
  instance_type = var.insT
  ami = "ami-0f9fc25dd2506cf6d"
}