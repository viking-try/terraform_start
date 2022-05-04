variable "inbound_ports" {
    type = list(number)
    default = [80,443,445 ]
  
}

variable "outbound_ports" {
    type = list(number)
    default = [100,200]
  
}

resource "aws_security_group" "testsec" {
  name = "allow list"
  dynamic ingress {
      for_each = var.inbound_ports
      content{
          from_port = ingress.value
          to_port = ingress.value
          protocol = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }
  dynamic egress {
      for_each = var.outbound_ports
      iterator = outside_port
      content{
          from_port = outside_port.value
          to_port = outside_port.value
          protocol = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }
}

/*
Before dynamic block
  ingress {
    description = "all 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "all 443"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
*/

