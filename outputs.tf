output "bucket_name" {
  description = "Bucket name for static website"
  value       = module.terrahouse_aws.bucket_name
}


output "website_url" {
  description = "S3 Url for website hosting"
  value       = module.terrahouse_aws.s3_website_endpoint
}


output "cloudfront_url" {
  description = "The Cloudfront distribution url"
  value       = module.terrahouse_aws.cloudfront_url
}
