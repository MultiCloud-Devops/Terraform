terraform {
  backend "s3" {
    bucket = "multicloud-devops-statefile"  # Name of the S3 bucket where the state will be stored.
    key = "terraform.tfstate" # Path within the bucket where the state will be read/written.
    region = "ap-south-1"
    dynamodb_table = "terraform-state-lock-dynamo" # DynamoDB table used for state locking, note: first run Day4-s3bucket-DynamoDB-create-for-backend-statefile-remote-locking
    encrypt = true
  }
}