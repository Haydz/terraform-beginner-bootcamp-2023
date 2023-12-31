variable "user_uuid" {
  type        = string
  description = "The UUID of the user"

  validation {
    condition     = can(regex("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[4][a-fA-F0-9]{3}-[89aAbB][a-fA-F0-9]{3}-[a-fA-F0-9]{12}$", var.user_uuid))
    error_message = "The user_uuid must be a valid UUID. Example format: 123e4567-e89b-12d3-a456-426614174000."
  }
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-.]{1,61}[a-z0-9]$", var.bucket_name)) && length(var.bucket_name) <= 63
    error_message = "The bucket name must be a valid S3 bucket name: lowercase letters, numbers, and hyphens, between 3 and 63 characters long."
  }
}

variable "index_html_filepath" {
  type = string

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The path for the index.html file does not exist"
  }
}

variable "error_html_filepath" {
  type = string

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The path for the error.html file does not exist"
  }
}

variable "content_version" {
  type        = number
  description = "The version number, must be a positive integer"

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer."
  }
}


variable "assets_path" {
  type        = string
  description = "path where assets are stored"
}
