resource "aws_instance" "webServ" {
  instance_type = lookup(var.instance_type, terraform.workspace)
  ami = "ami-0f9fc25dd2506cf6d"
}
variable "instance_type" {
    type = map
    default = {
        prod = "m4.large"
        dev = "t3.large"
    }
  
}