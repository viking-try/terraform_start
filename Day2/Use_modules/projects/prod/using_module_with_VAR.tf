module "ec2withVAR" {
    source = "../../modules/ec2_with_var"
    insT = "t2.micro"    
    #intT is variable name of mudules instnace type vraibale. Now we can pass intT with the desired value.
  
}