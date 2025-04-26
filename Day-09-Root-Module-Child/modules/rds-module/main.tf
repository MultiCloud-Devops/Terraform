resource "aws_db_instance" "dev_book_db" {
  allocated_storage = var.allocated_storage
  identifier = var.identifier
  db_name = var.db_name
  engine = var.engine
  engine_version = var.engine_version
  instance_class =var.instance_class
  username = var.username
  password = var.password
  parameter_group_name = var.parameter_group_name
  db_subnet_group_name = var.db_subnet_group_name
  publicly_accessible =var.publicly_accessible

  backup_retention_period = var.backup_retention_period
  backup_window = var.backup_window

  monitoring_interval = var.monitoring_interval
#   monitoring_role_arn = aws_iam_role.dev_rds_monitoring.ar
  
  maintenance_window = var.maintenance_window

  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot
  vpc_security_group_ids = var.vpc_security_group_ids
# #   depends_on = [ aws_security_group.dev_sg_primary, aws_db_subnet_group.dev_subnet_group ]
}




# resource "aws_db_instance" "dev_book_db" {
#   allocated_storage = 10
#   identifier = "dev-book-rds"
#   db_name = "bookdb"
#   engine = "mysql"
#   engine_version = "8.0"
#   instance_class ="db.t3.micro" 
#   username = "admin"
#   password = "Adminpassword123"
#   parameter_group_name = "default.mysql8.0"
#   db_subnet_group_name = aws_db_subnet_group.dev_subnet_group.name
#   publicly_accessible = true

#   backup_retention_period = 7
#   backup_window = "03:00-04:00"

#   monitoring_interval = 60
#   monitoring_role_arn = aws_iam_role.dev_rds_monitoring.ar
  
#   maintenance_window = "sun:04:00-sun:05:00"

# #   deletion_protection = true
#   skip_final_snapshot = true
#   provider = aws.secondarys
#   vpc_security_group_ids = [aws_security_group.dev_sg_primary.id]
# #   depends_on = [ aws_security_group.dev_sg_primary, aws_db_subnet_group.dev_subnet_group ]
# }



# resource "aws_iam_role" "dev_rds_monitoring" {
#     name = "dev_rds_monitoring"
#     provider = aws.secondarys
#      assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "monitoring.rds.amazonaws.com"
#       }
#     }]
#   })
# }
    
# # IAM Policy Attachment for RDS Monitoring
# resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
#     provider = aws.secondarys
#     role       = aws_iam_role.dev_rds_monitoring.name
#     policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
# }

# resource "aws_db_subnet_group" "dev_subnet_group" {
#   name="dev_subnet_group"
#   subnet_ids = ["subnet-0da63523572b88266","subnet-0c569e00f9d278fec"]
#   provider = aws.secondarys
# }