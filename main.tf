
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.1"

    }
  }
}

resource "random_string" "bucket_name" {
  length  = 16
  lower   = true
  upper   = false
  special = false
  # override_special = ""
}

resource "aws_s3_bucket" "example" {
  bucket = "haydn-${random_string.bucket_name.result}"


  # tags = {
  #   Name        = "My bucket"
  #   Environment = "Dev"
  # }
}


output "random_bucket_name" {

  value = aws_s3_bucket.example.bucket

}
