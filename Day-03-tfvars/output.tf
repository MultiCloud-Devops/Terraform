output "tfvars_server_1_publicip" {
  value = aws_instance.tfvars_server_1.public_ip
}
output "tfvars_server_1_privateip" {
  value = aws_instance.tfvars_server_1.private_ip
  sensitive = true
}
output "tfvars_server_1_az" {
  value = aws_instance.tfvars_server_1.availability_zone
}
output "tfvars_server_1_tag" {
  value = aws_instance.tfvars_server_1.tags["Name"]
}