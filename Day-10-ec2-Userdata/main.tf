resource "aws_instance" "dev_userdata_server" {
   ami="ami-0f1dcc636b69a6438"
   instance_type = "t2.micro"
   user_data = file("httpd.sh")
   tags = {
      Name="jenkins_github_hook_triggers_server"
   }
}