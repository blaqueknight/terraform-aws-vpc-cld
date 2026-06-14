terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "aws_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name                = var.name
  cidr                = var.cidr
  azs                 = var.azs
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  database_subnets    = var.database_subnets

  enable_nat_gateway  = var.enable_nat_gateway
  single_nat_gateway  = var.single_nat_gateway

  create_database_subnet_group       = true
  create_database_subnet_route_table = true
  create_database_nat_gateway_route  = false

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = var.tags
}
