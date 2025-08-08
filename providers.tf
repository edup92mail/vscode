#################################
# Providers Block
##################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Project = var.Tags.Project
      Repo    = var.Tags.Repo
    }
  }
}
