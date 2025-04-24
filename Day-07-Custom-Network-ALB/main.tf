#vpc-creation
resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true 
  tags = {
    Name = "dev_vpc"
  }
}

#IG
resource "aws_internet_gateway" "dev_ig" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name ="dev_ig"
  }

}

#subnet
resource "aws_subnet" "dev_public_subnet1" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.dev_vpc.id
  availability_zone = "ap-south-1b"
  tags = {
    Name="dev_public_subnet"
  }

}

resource "aws_subnet" "dev_public_subnet2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.dev_vpc.id
  availability_zone = "ap-south-1a"
  tags = {
    Name="dev_public_subnet2"
  }

}

#route table
resource "aws_route_table" "dev_public_route_table" {
    vpc_id = aws_vpc.dev_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev_ig.id
    }
    tags = {
      Name ="dev_public_rt"
    }
}

resource "aws_route_table_association" "dev_public_route_table_association" {
    subnet_id = aws_subnet.dev_public_subnet1.id
    route_table_id =  aws_route_table.dev_public_route_table.id
  
}

resource "aws_route_table_association" "dev_public_route_table_association2" {
    subnet_id = aws_subnet.dev_public_subnet2.id
    route_table_id =  aws_route_table.dev_public_route_table.id
  
}

#security group
resource "aws_security_group" "dev_sg" {
  vpc_id = aws_vpc.dev_vpc.id
  ingress{
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }
  ingress{
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "dev_sg"
  }
}

resource "aws_key_pair" "dev_keypair" {
    key_name = "public"
    public_key = file("~/.ssh/id_ed25519.pub") 
  
}

#public instance
resource "aws_instance" "dev_public_instance" {
    ami="ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.dev_public_subnet1.id
    security_groups = [ aws_security_group.dev_sg.id ]
    associate_public_ip_address = true
    key_name = aws_key_pair.dev_keypair.key_name
    tags = {
      Name ="dev_public_server"
    }
}

#target group
resource "aws_lb_target_group" "dev-tg" {
  name = "dev-tg"
  protocol = "HTTP"
  port = 80
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name ="dev-tg"
  }
}
#target group listener
resource "aws_lb_listener" "aws_lb_listener" {
    load_balancer_arn = aws_lb.dev-lb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      
      type = "forward"
      target_group_arn = aws_lb_target_group.dev-tg.arn
    }
  
}

#load balancer
resource "aws_lb" "dev-lb" {
    name = "dev-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.dev_sg.id ]
    subnets = [aws_subnet.dev_public_subnet1.id, aws_subnet.dev_public_subnet2.id ]
    tags = {
      Name ="dev-lb"
    }
}

#target group attachement
resource "aws_lb_target_group_attachment" "dev_tg_attachment1" {
  target_group_arn = aws_lb_target_group.dev-tg.arn
  target_id = aws_instance.dev_public_instance.id
  port = 80
}