module "ec2" {
    source = "../../modules/ec2"
    #instance_type = "t2.large" 
    #instance type will give an error becuse its hardcoded in module. If it was var in module then it would have worked. 
}