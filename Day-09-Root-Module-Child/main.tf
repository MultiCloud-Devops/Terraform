module "dev_ec2" {
  source = "./modules/ec2-module"
  ami = var.ami
  instance_type = var.instance_type
}

module "dev_s3" {
  source = "./modules/s3-module"
  bucket = var.bucket
}