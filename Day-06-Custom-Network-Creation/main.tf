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
resource "aws_subnet" "dev_public_subnet" {
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
    subnet_id = aws_subnet.dev_public_subnet.id
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
    subnet_id = aws_subnet.dev_public_subnet.id
    security_groups = [ aws_security_group.dev_sg.id ]
    associate_public_ip_address = true
    key_name = aws_key_pair.dev_keypair.key_name
    tags = {
      Name ="dev_public_server"
    }
}




#private server setup
# #elastic ip
# resource "aws_eip" "dev_eip" {
#   domain = "vpc"
# }

# #natgateway
# resource "aws_nat_gateway" "dev_nat" {
#   allocation_id = aws_eip.dev_eip.id
#   subnet_id     =aws_subnet.dev_public_subnet.id

#   tags = {
#     Name = "dev_nat"
#   }
#   depends_on = [ aws_internet_gateway.dev_ig ]
# }

#private subnet
resource "aws_subnet" "dev_private_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.dev_vpc.id
  availability_zone = "ap-south-1a"
  tags = {
    Name="dev_private_subnet"
  }

}


#private route table
resource "aws_route_table" "dev_private_route_table" {
    vpc_id = aws_vpc.dev_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        #gateway_id = aws_nat_gateway.dev_nat.id
    }
    tags = {
      Name ="dev_private_rt"
    }
}

resource "aws_route_table_association" "dev_private_route_table_association" {
    subnet_id = aws_subnet.dev_private_subnet.id
    route_table_id =  aws_route_table.dev_private_route_table.id
  
}


#private instance
resource "aws_instance" "dev_private_instance" {
    ami="ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.dev_private_subnet.id
    security_groups = [ aws_security_group.dev_sg.id ]
    key_name = aws_key_pair.dev_keypair.key_name
    tags = {
      Name ="dev_private_server"
    }
}


#mysql db instance
#RDS subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
  subnet_ids = [aws_subnet.dev_public_subnet.id, aws_subnet.dev_public_subnet2.id]
  name = "rds_subnet_group"
  tags = {
    Name = "rds_subnet_group"
  }
}

#RDS db instance
resource "aws_db_instance" "default" {
  allocated_storage    = 20
  db_name              = "dev"
  engine               = "mysql"
  engine_version       = "8.0.41"
  instance_class       = "db.t4g.micro"
  username             = "admin"
  password             = "Adminpassword123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  publicly_accessible = true
  tags = {
    Name = "db_instance"
  }
}
