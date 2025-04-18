resource "aws_instance" "tf_instance_1" {
  ami = var.tf_instance_ami
  instance_type = var.tf_instance_instance_type
}