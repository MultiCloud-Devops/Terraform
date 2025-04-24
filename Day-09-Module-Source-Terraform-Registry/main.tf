module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "terraform-module-bucket-testing-terraform"
#   acl    = "private"

#   control_object_ownership = true
#   object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "ec2_from_terraform_repo"

  instance_type          = "t2.micro"
  key_name               = "Cust-KeyPair"
  vpc_security_group_ids = ["sg-045ccca8575ceb346"]
  subnet_id              = "subnet-0ab113ab778a01cf7"

  tags = {
    Name = "ec2_from_terraform_repo"
    Terraform   = "true"
    Environment = "dev"
  }
}