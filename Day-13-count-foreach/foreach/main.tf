variable "servers_list" {
  type = list(string)
  default = [ "dev_tf_server1",  "dev_tf_server3" ]
}

resource "aws_instance" "dev_tf_with_list_count" {
  ami="ami-002f6e91abff6eb96"
  instance_type = "t2.micro"
  for_each = toset(var.servers_list)
  tags = {
    Name = each.value
  }
}