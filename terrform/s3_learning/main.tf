provider "aws" {
  region  = "us-east-2"
  profile = "tf-carlos"
}

resource "aws_s3_bucket" "meu_bucket" {
  bucket = "my-tf-test-bucket-carlos-teste"
  tags = {
    Name        = "My bucket"
    Environment = "Dev",
    ManagedBy   = "Terraform"
  }
}
resource "aws_s3_bucket_acl" "acl_config" {
  bucket = aws_s3_bucket.meu_bucket.id
  acl    = "private"
}