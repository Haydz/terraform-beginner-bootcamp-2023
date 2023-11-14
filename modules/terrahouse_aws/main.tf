terraform {
  # cloud {
  #   organization = "terrorhaydz"

  #   workspaces {
  #     name = "terrahouse-1"
  #   }
  # }

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "5.23.1"
    }

  }
}

provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  tags = {
    UserUuid = var.user_uuid
    Employee = "Haydn Johnson"
  }
}
