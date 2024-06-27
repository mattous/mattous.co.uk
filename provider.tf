terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "tf-mattous-state"
    key    = "state-mattous-co.uk"
    region = "eu-west-2"
  }

}

provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      Environment = "Test"
      Owner       = "Mattous"
      Project     = "mattous.co.uk"
    }
  }
}