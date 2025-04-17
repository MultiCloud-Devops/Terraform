tfvars_server_ami = ""
tfvars_server_instance_type = ""
tfvars_server_1_instance_tag = ""
tfvars_server_2_instance_tag = ""
tfvars_bucket = ""


#note: if the name is defualt terraform.tfvars we can run regular process no need to mention 
#Note: if user can give custom .tfvars name like example dev.tfvars process follow below 
# terraform plan -var-file="dev.tfvars"
# terraform apply -var-file="dev.tfvars"