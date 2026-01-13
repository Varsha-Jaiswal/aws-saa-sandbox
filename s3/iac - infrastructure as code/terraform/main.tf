terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.28.0"
    }
  }
}

provider "aws" {
  # Configuration options like region
  region = "eu-west-2" ## Region where the bucket will be created, when I change this, the bucket will be created in that region and it was taking time to create the bucket as compared to the default region.
}