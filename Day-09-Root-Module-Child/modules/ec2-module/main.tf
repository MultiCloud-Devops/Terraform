resource "aws_instance" "module_ec2" {
  ami = var.ami
  instance_type = var.instance_type
}