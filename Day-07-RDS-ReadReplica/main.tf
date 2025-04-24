#primary region
#RDS instance
resource "aws_db_instance" "dev_book_db" {
  allocated_storage = 10
  identifier = "dev-book-rds"
  db_name = "bookdb"
  engine = "mysql"
  engine_version = "8.0"
  instance_class ="db.t3.micro" 
  username = "admin"
  password = "Adminpassword123"
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.dev_subnet_group.name
  publicly_accessible = true

  backup_retention_period = 7
  backup_window = "03:00-04:00"

  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.dev_rds_monitoring.arn
  
  maintenance_window = "sun:04:00-sun:05:00"

#   deletion_protection = true
  skip_final_snapshot = true
  provider = aws.secondarys
  vpc_security_group_ids = [aws_security_group.dev_sg_primary.id]
  depends_on = [ aws_security_group.dev_sg_primary, aws_db_subnet_group.dev_subnet_group ]
}

resource "aws_iam_role" "dev_rds_monitoring" {
    name = "dev_rds_monitoring"
    provider = aws.secondarys
     assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}
    
# IAM Policy Attachment for RDS Monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
    provider = aws.secondarys
    role       = aws_iam_role.dev_rds_monitoring.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_db_subnet_group" "dev_subnet_group" {
  name="dev_subnet_group"
  subnet_ids = ["subnet-0da63523572b88266","subnet-0c569e00f9d278fec"]
  provider = aws.secondarys
}


#security group
resource "aws_security_group" "dev_sg_primary" {
  vpc_id = "vpc-07d5616e96e1832bd"
  provider = aws.secondarys
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
  ingress{
    from_port = 3306
    to_port = 3306
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "MySQL"
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "dev_sg_primary"
  }
}







#Read Replica 
#private network
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
  ingress{
    from_port = 3306
    to_port = 3306
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "MySQL"
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

resource "aws_db_subnet_group" "dev_rr_subnet_group" {
    subnet_ids = [aws_subnet.dev_public_subnet.id, aws_subnet.dev_public_subnet2.id ]
    name = "dev_rr_subnet_group"
    tags = {
      Name ="dev_rr_subnet_group"
    }
}

resource "aws_db_instance" "dev_rds_read_replica" {
  identifier = "dev-rds-read-replica"
  replicate_source_db = aws_db_instance.dev_book_db.arn
  instance_class = "db.t3.micro"

  db_subnet_group_name = aws_db_subnet_group.dev_rr_subnet_group.name
  publicly_accessible = true
  depends_on = [ aws_db_instance.dev_book_db, aws_internet_gateway.dev_ig, aws_vpc.dev_vpc, aws_security_group.dev_sg ]
  vpc_security_group_ids = [aws_security_group.dev_sg.id]
  skip_final_snapshot = true
#   skip_final_snapshot = false
#   final_snapshot_identifier = "my-final-snapshot"
}