terraform {
  # cloud {
  #   organization = "terrorhaydz"

  #   workspaces {
  #     name = "terrahouse-1"
  #   }
  # }

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

provider "aws" {

  region = "us-east-1" # Replace with your desired region

}
