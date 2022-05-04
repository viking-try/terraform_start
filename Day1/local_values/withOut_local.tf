resource "aws_instance" "name2" {
    ami = "ami-0f9fc25dd2506cf6d"
    instance_type = "t2.nano"
    tags=local.my_tags
}

#still work . loacal value works within module and var is global will learn what that is in modules 