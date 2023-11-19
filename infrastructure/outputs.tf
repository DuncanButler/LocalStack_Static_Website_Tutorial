output "arn" {
    description = "ARN of the s3 bucket."
    value = aws_s3_bucket.s3_bucket.arn
}

output "name" {
    description = "Name (id) of the s3 bucket."
    value = aws_s3_bucket.s3_bucket.id
}

output "domain" {
    description = "Domain name of the s3 bucket."
    value = aws_s3_bucket_website_configuration.s3_bucket.website_domain
}

output "website_endpoint" {
    value = aws_s3_bucket_website_configuration.s3_bucket.website_endpoint
}