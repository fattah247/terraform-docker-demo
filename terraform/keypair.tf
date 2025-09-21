resource "aws_key_pair" "tf_demo" {
  key_name   = var.ssh_key_name
  public_key = file("~/.ssh/tf-demo.pub")
}
