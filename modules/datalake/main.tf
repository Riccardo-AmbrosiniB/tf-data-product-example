resource "aws_s3_bucket" "s3_raw_zone" {
  bucket = "${var.lake_name}-landing-zone"
  timeouts {
    create = "15s"
    delete = "15s"
    read = "15s"
    update = "15s"
  }
}

resource "aws_s3_bucket" "s3_development_zone" {
  bucket = "${var.lake_name}-development-zone"
  timeouts {
    create = "15s"
    delete = "15s"
    read = "15s"
    update = "15s"
  }
}

resource "aws_s3_bucket" "s3_production_zone" {
  bucket = "${var.lake_name}-production-zone"
  timeouts {
    create = "15s"
    delete = "15s"
    read = "15s"
    update = "15s"
  }
}
