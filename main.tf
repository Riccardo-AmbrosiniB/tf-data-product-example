terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-south-1"
  profile = "quantyca-gian"
}

#Deploy S3 structured bucket
module "datalake" {
  source = "./modules/datalake"
  lake_name = var.lake_name
}
