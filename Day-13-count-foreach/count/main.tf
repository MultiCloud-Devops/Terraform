# resource "aws_instance" "dev_tf_without_count" {
#   ami="ami-002f6e91abff6eb96"
#   instance_type = "t2.micro"
#   count=2
#   tags = {
#     Name = "dev"
#   }
# }


# resource "aws_instance" "dev_tf_with_count" {
#   ami="ami-002f6e91abff6eb96"
#   instance_type = "t2.micro"
#   count=2
#   tags = {
#     Name = "dev-${count.index+1}"
#   }
# }

variable "servers_list" {
  type = list(string)
  default = [ "dev1", "test2", "prod3" ]
}

resource "aws_instance" "dev_tf_with_list_count" {
  ami="ami-002f6e91abff6eb96"
  instance_type = "t2.micro"
  count=length(var.servers_list)
  tags = {
    Name = var.servers_list[count.index]
  }
}