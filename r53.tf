resource "aws_route53_record" "static_domain" {
  zone_id = var.route53_zone_id
  name    = var.static_website_address
  type    = "A"
  alias {
    name                   = aws_s3_bucket_website_configuration.static_site.website_domain
    zone_id                = aws_s3_bucket.cloudfront_bucket.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "cloudfront_domain" {
  zone_id = var.route53_zone_id
  name    = var.cloudfront_website_address
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.my-distribution.domain_name
    zone_id                = aws_cloudfront_distribution.my-distribution.hosted_zone_id
    evaluate_target_health = true
  }
}