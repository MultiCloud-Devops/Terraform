resource "aws_instance" "tfvars_server_1" {
  ami=var.tfvars_server_ami
  instance_type = var.tfvars_server_instance_type
  tags = {
    Name=var.tfvars_server_1_instance_tag
  }
}

resource "aws_instance" "tfvars_server_2" {
    ami = var.tfvars_server_ami
    instance_type = var.tfvars_server_instance_type
    tags = {
      Name = var.tfvars_server_2_instance_tag
    }
  
}
resource "aws_s3_bucket" "tfvars_bucket" {
  bucket = var.tfvars_bucket
}

#terraform destroy -target=aws_s3_bucket.tfvars_bucket if we want control particular resource use Target 