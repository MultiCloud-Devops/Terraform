resource "aws_vpc" "tf_vpc" {
  cidr_block = var.tf_vpc_cidr
  depends_on = [ aws_instance.tf_instance ]
}
resource "aws_instance" "tf_instance" {
  ami = var.tf_instance_ami
  instance_type = var.tf_instance_type
}