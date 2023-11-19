

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

data "aws_caller_identity" "current" {}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
