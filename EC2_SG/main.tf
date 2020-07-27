resource "aws_vpc" "mainname" {
  cidr_block = "10.0.0.0/16" 
  tags = {
    Name = "main2"
  }
}
resource "aws_instance" "testtara" {
  key_name = "test"
  ami = "ami-08f3d892de259504d"
  instance_type = "t2.micro"
  tags = {
    Name = "test_tera"
  }
}
resource "aws_eip" "eip" {
  instance = "${aws_instance.testtara.id}"
}
output "publicip" {
  value = "${aws_eip.eip.public_ip}"
}

output "instance_id" {
  value = "${aws_instance.testtara.id}"
}





