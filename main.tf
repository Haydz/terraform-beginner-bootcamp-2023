


# resource "random_string" "bucket_name" {
#   length  = 16
#   lower   = true
#   upper   = false
#   special = false
#   # override_special = ""
# }

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  tags = {
    UserUuid = var.user_uuid
    Employee = "Haydn Johnson"
  }
}
