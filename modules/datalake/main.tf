resource "aws_s3_bucket" "s3_raw_zone" {
  bucket = var.lake_name + "-landing-zone"
}

resource "aws_s3_bucket" "s3_development_zone" {
  bucket = var.lake_name + "-development-zone"
}

resource "aws_s3_bucket" "s3_production_zone" {
  bucket = var.lake_name + "-production-zone"
}