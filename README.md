A reusable Terraform module for deploying an AWS VPC with configurable public and private subnets, Internet Gateway, NAT Gateway, and route tables.

## Features
-Configurable VPC CIDR
-Multiple public subnets
-Multiple private subnets
-Internet Gateway
-Optional NAT Gateway
-Public and private route tables
-Configurable DNS settings
-Common resource tagging

## Example Usage
module "vpc" {
  source = "../.."

  vpc_name = "example-vpc"
  vpc_cidr = "10.0.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]

  enable_nat_gateway = true
  single_nat_gateway = true
}

## Inputs
-vpc_name
-vpc_cidr
-availability_zones
-public_subnet_cidrs
-private_subnet_cidrs
-enable_nat_gateway
-single_nat_gateway
-enable_dns_hostnames
-enable_dns_support
-tags

## Outputs
-vpc_id
-vpc_cidr_block
-public_subnet_ids
-private_subnet_ids
-nat_gateway_ids
-internet_gateway_id
-public_route_table_ids
-private_route_table_ids