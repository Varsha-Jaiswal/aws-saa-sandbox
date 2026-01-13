# Documentation: https://developer.hashicorp.com/terraform/tutorials/aws-get-started
resource "aws_s3_bucket" "s3-bucket" {
  bucket = "s3-sandbox-vj-tf"

  tags = {
    Name        = "s3-sandbox-vj-tf"
    Environment = "Dev"
  }
}