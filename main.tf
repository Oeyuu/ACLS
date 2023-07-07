provider "kafka" {
  bootstrap_servers = var.bootstrap_servers
  sasl_username     = var.super_user_sasl_username
  sasl_password     = var.super_user_sasl_password
  sasl_mechanism    = "scram-sha512"
  tls_enabled       = true
  skip_tls_verify   = false 
}

provider "aws" {
  region = "eu-central-1"
}