variable "ami_id" {
    type = string
    default = "ami-002f6e91abff6eb96"
}
variable "instance_type" {
    type = string
    default = "t2.micro"
}
variable "region" {
    type = string
    default = "ap-south-1"
  
}
variable "az" {
  type = string
  default = "ap-south-1a"
}
variable "instance_tag" {
  type = string
  default = "tf_aws"
}