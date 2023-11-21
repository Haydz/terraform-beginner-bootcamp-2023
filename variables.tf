variable "user_uuid" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "index_html_filepath" {
  type    = string
  default = "/public/index.html"
}

variable "error_html_filepath" {
  type    = string
  default = "/public/error.html"
}

variable "assets_path" {
  type    = string
  default = "/public/assets/"
}
# index_html_filepath =
# error_html_filepath =

# variable "bucket_name" {
#   type        = string
#   description = "The name of the S3 bucket"

#   validation {
#     condition     = can(regex("^[a-z0-9][a-z0-9-.]{1,61}[a-z0-9]$", var.bucket_name)) && length(var.bucket_name) <= 63
#     error_message = "The bucket name must be a valid S3 bucket name: lowercase letters, numbers, and hyphens, between 3 and 63 characters long."
#   }
# }


variable "content_version" {
  type        = number
  description = "The version number, must be a positive integer"
}
