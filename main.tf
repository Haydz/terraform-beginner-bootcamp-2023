terraform {
  cloud {
    organization = "terrorhaydz"

    workspaces {
      name = "terraform-cloud"
    }
  }
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  # user_uuid   = "c96b5d6c-e138-4a75-8f2d-70c4da5786d3"
  # bucket_name = "haydn-31s850ggs4hym76c"
  user_uuid   = var.user_uuid
  bucket_name = var.bucket_name

  index_html_filepath = "${path.root}${var.index_html_filepath}"
  error_html_filepath = "${path.root}${var.error_html_filepath}"
  content_version     = var.content_version
  assets_path         = "${path.root}${var.assets_path}"
}


# terraform {
#   # cloud {
#   #   organization = "terrorhaydz"

#   #   workspaces {
#   #     name = "terrahouse-1"
#   #   }
#   # }

#   required_providers {

#     aws = {
#       source  = "hashicorp/aws"
#       version = "5.23.1"
#     }

#   }
# }



# resource "random_string" "bucket_name" {
#   length  = 16
#   lower   = true
#   upper   = false
#   special = false
#   # override_special = ""
# }

#
