resource "aws_cloudfront_distribution" "my-distribution" {
  origin {
    domain_name = aws_s3_bucket.cloudfront_bucket.bucket_domain_name
    origin_id   = "S3-Origin"
  }

  aliases = [var.cloudfront_website_address]

  enabled = true
    default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-Origin"

    viewer_protocol_policy = "redirect-to-https"

    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

  }

  viewer_certificate {
    acm_certificate_arn = var.https_cert_arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.my-distribution.domain_name
}