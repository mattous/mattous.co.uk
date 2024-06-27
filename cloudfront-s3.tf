resource "aws_s3_bucket" "cloudfront_bucket" {
  bucket = var.cloudfront_website_address
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "cloudfront_site" {
  bucket = aws_s3_bucket.cloudfront_bucket.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "cloudfront_site_access_block" {
  bucket = aws_s3_bucket.cloudfront_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "cloudfront_upload_object" {
  for_each      = fileset("html/", "*")
  bucket        = aws_s3_bucket.cloudfront_bucket.id
  key           = each.value
  source        = "html/${each.value}"
  etag          = filemd5("html/${each.value}")
  content_type  = "text/html"
}

resource "aws_s3_bucket_policy" "cloudfront_bucket_policy" {
  bucket = aws_s3_bucket.cloudfront_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "${var.static_website_address}-Policy"
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.cloudfront_bucket.arn}/**"
        ]
      }
    ]
  })
  
  depends_on = [ aws_s3_bucket_public_access_block.public_access_block ]
}
