resource "aws_key_pair" "ssh_key_web" {
  key_name   = "mydey"
  public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_instance" "name2" {
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key_web.key_name
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> logs.txt"
  }

  provisioner "remote-exec" {
      inline = ["sudo echo 'jai mata di' >> /tmp/logs.txt ",
        "sudo echo ${self.public_ip} >> logs.txt",
        "sudo yum install httpd -y",
      "sudo systemctl start httpd"]
      connection {
        type        = "ssh"
        user        = "ec2-user"
        host        = self.public_ip
        private_key = file("${path.module}/2nd")
      }
    }

  
}

