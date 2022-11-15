provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_instance" "my_server" {
  ami           = var.aws_instance_ami
  instance_type = var.aws_instance_type

  tags = {
    Name = "HelloWorld"
  }
}