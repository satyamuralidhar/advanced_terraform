terraform {
  required_version = "1.6.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = var.location
  default_tags {
    tags = {
      Environment = "Stage"
      Application = "threetier"
    }
  }
}
