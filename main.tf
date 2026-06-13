terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  name                = var.name
  cidr                = var.cidr
  azs                 = var.azs
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  database_subnets    = var.database_subnets
  enable_nat_gateway  = var.enable_nat_gateway
  single_nat_gateway  = var.single_nat_gateway
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                = var.tags
}
