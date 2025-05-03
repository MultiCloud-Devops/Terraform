resource "aws_instance" "dev_taint_untaint_server" {
  ami = "ami-002f6e91abff6eb96"
  instance_type = "t2.micro"
  key_name = aws_key_pair.dev_taint_key.key_name


}

resource "aws_key_pair" "dev_taint_key" {
    key_name = "dev_taint_key"
    public_key = file("~/.ssh/id_ed25519.pub")
}

 
#Use taint when you want Terraform to handle recreation without touching .tf code. It’s useful for controlled replacements during debugging or incident response.
# terraform taint aws_instance.name 
# terraform untaint aws_instance.name
#terraform replace is the modern alternative to terraform taint starting from Terraform v1.1+.
#example command ""terraform plan -replace=aws_instance.name"""