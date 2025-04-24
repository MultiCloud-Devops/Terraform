module "ec2_default_module" {
  source = "../Day-08-Module-Source"
  tfvars_server_ami = "ami-002f6e91abff6eb96"
  tfvars_server_instance_type = "t2.micro"
  tfvars_server_1_instance_tag = "ec2_from_module"
}