terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "dp-deployments"
    region = "eu-south-1"
    profile = "quantyca-gian"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  profile = "quantyca-gian"
}

#Deploy S3 structured bucket
module "datalake" {
  source = "./modules/datalake"
  lake_name = var.lake_name
}
