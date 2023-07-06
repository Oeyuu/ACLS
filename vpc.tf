module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "4.0.0"

  name = "my_vpc"
  cidr = "10.204.0.0/16"

  azs             = data.aws_availability_zones.available.names
  public_subnets  = ["10.204.1.0/26"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  manage_default_security_group = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}