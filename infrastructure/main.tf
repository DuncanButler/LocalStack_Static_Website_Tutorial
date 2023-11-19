# create s3 bucket
resource "aws_s3_bucket" "s3_bucket" {
    bucket = var.bucket_name
    tags = var.tags
}

# configure bucket for website hosting
resource "aws_s3_bucket_website_configuration" "s3_bucket" {
    bucket = aws_s3_bucket.s3_bucket.id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
}

# configure the bucket access policy
resource "aws_s3_bucket_acl" "s3_bucket" {
    bucket = aws_s3_bucket.s3_bucket.id
    acl = "public-read"
}

# configure the s3 bucket policies
resource "aws_s3_bucket_policy" "s3_bucket" {
    bucket = aws_s3_bucket.s3_bucket.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Sid = "PublicReadGetObject"
                Effect = "Allow"
                Principle = "*"
                Action = "s3:GetObject"
                Resource = [
                    aws_s3_bucket.s3_bucket.arn,
                    "${aws_s3_bucket.s3_bucket.arn}/*",
                ]
            },
        ]
    })
}

# upload files to the s3 bucket
resource "aws_s3_object" "object_www" {
    depends_on = [ aws_s3_bucket.s3_bucket ]
    for_each = fileset("${path.root}", "../src/www/*.html")
    bucket = var.bucket_name
    key = basename(each.value)
    source = each.value
    etag = filemd5("${each.value}")
    content_type = "text/html"
    acl = "public-read"
}
