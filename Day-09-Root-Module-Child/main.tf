module "dev_ec2" {
  source = "./modules/ec2-module"
  ami = var.ami
  instance_type = var.instance_type
}

module "dev_s3" {
  source = "./modules/s3-module"
  bucket = var.bucket
}

module "dev_db_subnet_group" {
  source = "./modules/db-subnet-group-module"
  name="dev_subnet_group"
  subnet_ids = ["subnet-0892b957bec13d294","subnet-0ab113ab778a01cf7"]
}

module "dev_rds" {
  source = "./modules/rds-module"
  allocated_storage = 10
  identifier = "dev-book-rds"
  db_name = "bookdb"
  engine = "mysql"
  engine_version = "8.0"
  instance_class ="db.t3.micro" 
  username = "admin"
  password = "Adminpassword123"
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = module.dev_db_subnet_group.db_subnet_group_id
  publicly_accessible = true

  backup_retention_period = 7
  backup_window = "03:00-04:00"

  # monitoring_interval = 60
  # # monitoring_role_arn = aws_iam_role.dev_rds_monitoring.ar
  
  maintenance_window = "sun:04:00-sun:05:00"

  deletion_protection = false
  skip_final_snapshot = true
  vpc_security_group_ids = ["sg-045ccca8575ceb346"]
  depends_on = [ module.dev_db_subnet_group ]
}