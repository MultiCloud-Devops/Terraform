provider "aws" {
    profile = "dev"
    alias = "acc1-ap-south-1"
  
}

provider "aws" {
    profile = "test"
    alias = "acc2-us-east-1"
  
}

resource "aws_s3_bucket" "dev_tf_dev_profile_bucket" {
  bucket = "dev-tf-profile1-bucket"
  provider = aws.acc1-ap-south-1
}

resource "aws_s3_bucket" "dev_tf_test_profile_bucket" {
  bucket = "dev-tf-profile2-bucket"
  provider = aws.acc2-us-east-1
}