terraform {
  backend "s3" {
    bucket = "teclify-sandbox-143805577160-terraform-state"
    key    = "msk/acls/terraform.tfstate"
    region = "eu-central-1"
  }

  required_providers {
    kafka = {
        source = "mongey/kafka"
        version = "0.5.2"
    }
  }
}
