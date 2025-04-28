resource "aws_instance" "dev_tf_local_exec_server" {
  ami           = "ami-002f6e91abff6eb96"
  instance_type = "t2.micro"
  tags = {
    Name = "dev_tf_local_exec_server"
  }

  provisioner "local-exec" {
    command = "echo Instance public IP is ${self.public_ip}, private IP is ${self.private_ip} > instance_info.txt"
  }
}