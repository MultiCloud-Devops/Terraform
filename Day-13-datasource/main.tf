data "aws_subnet" "dev_tf_subnet" {
  filter {
    name   = "tag:Name"
    values = ["default-subnet-ap-south-1b"]
  }
}

data "aws_ami" "dev_tf_aws_ami" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }

}

data "aws_ami" "dev_tf_my_ami" {
    most_recent = true
    owners = ["self"]
    filter {
      name = "tag:Name"
      values = ["ssm_session_manager_img"]

    }
  
}

resource "aws_instance" "dev_tf_data_source_instance" {
  ami = data.aws_ami.dev_tf_my_ami.id
  subnet_id = data.aws_subnet.dev_tf_subnet.id
  instance_type = "t2.micro"
  tags = {
    Name="dev_tf_data_source_instance"
  }
}