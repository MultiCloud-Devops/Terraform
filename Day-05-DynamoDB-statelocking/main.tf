resource "aws_instance" "tf_day05_instance_1" {
  ami = var.instance_aim
  instance_type = var.instance_type
  tags = {
    Name = var.instance_tag
  }
}