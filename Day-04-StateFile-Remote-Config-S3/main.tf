resource "aws_vpc" "tf_day04_vpc" {
  cidr_block = "10.0.0.0/16"
  tags={
    Name="tf_vpc1"
  }
}

resource "aws_subnet" "tf_day04_subnet1" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.tf_day04_vpc.id
  tags={
    Name="tf_subnet1"
  }
}

resource "aws_subnet" "tf_day04_subnet2" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.tf_day04_vpc.id
  tags={
    Name="tf_subnet2"
  }
}

resource "aws_subnet" "tf_day04_subnet4" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.tf_day04_vpc.id
  tags={
    Name="tf_subnet4"
  }
}
resource "aws_subnet" "tf_day04_subnet3" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.tf_day04_vpc.id
  tags={
    Name="tf_subnet3"
  }
}

resource "aws_subnet" "tf_day04_subnet5" {
  cidr_block = "10.0.4.0/24"
  vpc_id = aws_vpc.tf_day04_vpc.id
  tags={
    Name="tf_subnet5"
  }
}
