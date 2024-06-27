variable "route53_zone_id" {
  type        = string
  description = "Zone ID for DNS records"
}

variable "static_website_address" {
  type        = string
  description = "Web address for bucket and DNS record, for static S3 traffic (none https)"
}

variable "cloudfront_website_address" {
  type        = string
  description = "Web address for bucket and DNS record, for cloudfront"
}

variable "https_cert_arn" {
  type = string
  description = "ACM Certificate ARN for domain"
}
