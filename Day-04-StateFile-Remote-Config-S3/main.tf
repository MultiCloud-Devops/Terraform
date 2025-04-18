resource "aws_vpc" "tf_day04_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "tf_day04_subnet1" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.tf_day04_vpc.id
}

resource "aws_subnet" "tf_day04_subnet2" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.tf_day04_vpc.id
}