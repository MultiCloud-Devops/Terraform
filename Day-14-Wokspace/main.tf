resource "aws_key_pair" "dev_workspace_keypair" {
  key_name = "dev_workspace_keypair-dev"
  public_key = file("~/.ssh/id_ed25519.pub")
}