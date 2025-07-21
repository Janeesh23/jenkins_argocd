provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "statefile-terraform-janeesh-backend"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-state-lock-janeesh"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}