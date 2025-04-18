terraform{
    backend "s3" {
      bucket = "multicloud-devops-statefile"
      key="Day-04/terraform.tfstate"
      region = "ap-south-1"
    }
}