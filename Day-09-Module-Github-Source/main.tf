module "ec2_module_git_repo" {
  source = "github module 8 repo"
  tfvars_server_ami = "ami-002f6e91abff6eb96"
  tfvars_server_instance_type = "t2.micro"
  tfvars_server_1_instance_tag = "ec2_from_github_repo"
}