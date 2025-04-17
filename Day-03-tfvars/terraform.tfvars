tfvars_server_ami = "ami-002f6e91abff6eb96"
tfvars_server_instance_type = "t2.micro"
tfvars_server_1_instance_tag = "tfvars_server_1"
tfvars_server_2_instance_tag = "tfvars_server_2"
tfvars_bucket = "tfvars_bucket_s"


#note: if the name is defualt terraform.tfvars we can run regular process no need to mention 
#Note: if user can give custom .tfvars name like example dev.tfvars process follow below 
# terraform plan -var-file="dev.tfvars"
# terraform apply -var-file="dev.tfvars"