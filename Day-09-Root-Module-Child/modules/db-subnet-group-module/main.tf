resource "aws_db_subnet_group" "dev_subnet_group" {
  name=var.name
  subnet_ids = var.subnet_ids
}


# resource "aws_db_subnet_group" "dev_subnet_group" {
#   name="dev_subnet_group"
#   subnet_ids = ["subnet-0da63523572b88266","subnet-0c569e00f9d278fec"]
# }