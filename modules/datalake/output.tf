output "productionDataLakeEndpoint" {
  value = aws_s3_bucket.s3_production_zone.bucket_regional_domain_name
}

output "devDataLakeEndpoint" {
  value = aws_s3_bucket.s3_development_zone.bucket_regional_domain_name
}

