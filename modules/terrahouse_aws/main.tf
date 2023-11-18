# locals {
#   files_to_upload = {
#     "index.html" = "${path.root}/public/index.html",
#     "error.html" = "${path.root}/public/error.html"
#   }
# }


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


resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
# resource "aws_s3_object" "object" {
#   bucket = aws_s3_bucket.website_bucket.bucket
#   key    = "index.html"
#   source = "${path.root}/public/index.html"

#   # The filemd5() function is available in Terraform 0.11.12 and later
#   # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
#   # etag = "${md5(file("path/to/file"))}"
#   etag = filemd5("${path.root}/public/index.html")
# }

# Fo
locals {
  files_to_upload = {
    "index.html" = var.index_html_filepath
    "error.html" = var.error_html_filepath
  }
}

resource "aws_s3_object" "website_files" {
  for_each = local.files_to_upload

  bucket = aws_s3_bucket.website_bucket.bucket
  key    = each.key
  source = each.value
  etag   = filemd5(each.value)
}
