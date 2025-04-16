resource "aws_instance" "name" {
    ami = "ami-002f6e91abff6eb96"
    instance_type = "t2.micro"
    tags = {
        Name="case-4"
    }
    key_name = "Cust-KeyPair"
}