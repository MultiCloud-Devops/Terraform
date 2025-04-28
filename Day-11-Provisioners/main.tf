resource "aws_key_pair" "dev_tf_key_pair" {
  key_name = "test"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "dev_tf_proivisioners_server" {
  ami="ami-0e35ddab05955cf57"
  instance_type = "t2.micro"
  key_name = aws_key_pair.dev_tf_key_pair.key_name  
  tags = {
    Name = "dev_tf_proivisioners_server"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/id_ed25519")
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [ 
      "touch server-remote-exec-file",
      "echo file created from terraform provisioners >> server-remote-exec-file"
     ]

  }

  provisioner "local-exec" {
    command = "touch file-local-exec"
  }  

  provisioner "file" {
    source = "file-local-exec"
    destination = "/home/ubuntu/file-local-exec"
    
  }  

  depends_on = [ aws_instance.dev_tf_proivisioners_server ]
  
}