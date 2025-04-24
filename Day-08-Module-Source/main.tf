resource "aws_instance" "tfvars_server_1" {
  ami=var.tfvars_server_ami
  instance_type = var.tfvars_server_instance_type
  tags = {
    Name=var.tfvars_server_1_instance_tag
  }
}