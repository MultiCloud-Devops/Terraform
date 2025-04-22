resource "aws_instance" "tf_day05_instance_1" {
  ami = var.instance_aim
  instance_type = var.instance_type
  tags = {
    Name = var.instance_tag
  }
  availability_zone = var.instance_az

  lifecycle {
    #prevent_destroy = true
    ignore_changes = [ tags ]
    # create_before_destroy = true
  }
}
