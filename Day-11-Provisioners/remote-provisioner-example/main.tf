resource "aws_key_pair" "dev_tf_key_pair" {
  key_name = "test1"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "dev_tf_proivisioners_server" {
  ami="ami-002f6e91abff6eb96"
  instance_type = "t2.micro"
  key_name = aws_key_pair.dev_tf_key_pair.key_name  
  tags = {
    Name = "dev_tf_proivisioners_remote_server"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("~/.ssh/id_ed25519")
    host = self.public_ip
  } 

   provisioner "remote-exec" {
    inline = [ 
        "sudo yum update -y",
        "sudo yum install -y nginx",
        "sudo systemctl start nginx"
     ]

  }
    
}