# README

Creates a basic static site on cloudfront

Also a sub domain hosted just on S3 as a comparison. The S3 site will not use HTTPS.

## requirements 

- Create `terraform.tfvars`
- Domain name registered in route 53 
- Create a cert for the reginstered domain in ACM in the `us-east-1` region (this is a cloudfront requirement)
- Set `cloudfront_website_address` in `terraform.tfvars` to your domain name
- Set `static_website_address` in `terraform.tfvars` to the sub domain you wish to use. This is required by should be optional as it's a bit pointless.
- Set `route53_zone_id` in `terraform.tfvars` to the zone ID of your registered domain
- Set `https_cert_arn` in `terraform.tfvars` to the certificate ARN of your cert for the domain registered in ACM
