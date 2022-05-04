resource "aws_instance" "webServ" {
  instance_type = "t2.micro"
  ami = "ami-0f9fc25dd2506cf6d"
}