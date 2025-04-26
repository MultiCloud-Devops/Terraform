resource "aws_vpc" "dev_tf_import_vpc" {
  tags = {
    Name="default"
  }
}
resource "aws_subnet" "dev_tf_import_subnet" {
  vpc_id = "vpc-06ba7c48aead800bd"
  cidr_block = "172.31.0.0/20" 
  map_public_ip_on_launch = true
}
resource "aws_instance" "dev_tf_import_instance" {
  instance_type ="t2.micro"
  ami = "ami-0f1dcc636b69a6438"
  tags = {
    Name = "terraform_import_test_server"
  }
}

resource "aws_s3_bucket" "dev_tf_import_s3_bucket" {
  
}
