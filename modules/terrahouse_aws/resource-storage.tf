locals {
  files_to_upload = {
    "index.html" = var.index_html_filepath
    "error.html" = var.error_html_filepath
  }
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  tags = {
    UserUuid = var.user_uuid
    Employee = "Haydn Johnson"
  }
}






#
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


resource "aws_s3_object" "website_files" {
  for_each = local.files_to_upload

  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = each.key
  source       = each.value
  content_type = "text/html"
  etag         = filemd5(each.value)

  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes       = [etag]
  }
}

resource "aws_s3_object" "upload_assets" {
  for_each = fileset("${var.assets_path}", "*.{jpeg,png,gif}")
  bucket   = var.bucket_name
  key      = "assets/${each.key}"
  source   = "${var.assets_path}${each.key}"
  etag     = filemd5("${var.assets_path}${each.key}")
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes       = [etag]
  }
}

# https://aws.amazon.com/blogs/networking-and-content-delivery/amazon-cloudfront-introduces-origin-access-control-oac/
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket
  # policy = data.aws_iam_policy_document.allow_access_from_another_account.json
  policy = jsonencode({

    "Version" = "2012-10-17",
    "Statement" = {
      "Sid"    = "AllowCloudFrontServicePrincipalReadOnly",
      "Effect" = "Allow",
      "Principal" = {
        "Service" = "cloudfront.amazonaws.com"
      },
      "Action"   = "s3:GetObject",
      "Resource" = "arn:aws:s3:::${aws_s3_bucket.website_bucket.id}/*",
      "Condition" = {
        "StringEquals" = {
          "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
        }
      }
    }

    }

  )
}


resource "terraform_data" "content_version" {
  input = var.content_version
}

resource "terraform_data" "invalidate_cache" {
  triggers_replace = terraform_data.content_version

  provisioner "local-exec" {
    command = <<EOF
    aws cloudfront create-invalidation \
--distribution-id ${aws_cloudfront_distribution.s3_distribution.id} \
--paths '/*'
    EOF
  }
}
