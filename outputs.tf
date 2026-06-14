output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.network.public_subnets
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.network.private_subnets
}

output "database_subnet_ids" {
  description = "IDs of database subnets"
  value       = module.network.database_subnets
}

output "nat_gateways" {
  description = "List of NAT gateways"
  value       = module.network.nat_gateways
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.network.vpc_cidr_block
}

output "internet_gateway_id" {
  description = "The Internet Gateway ID"
  value       = module.network.igw_id
}

output "public_route_table_ids" {
  description = "List of public route table IDs"
  value       = module.network.public_route_table_ids
}

output "private_route_table_ids" {
  description = "List of private route table IDs"
  value       = module.network.private_route_table_ids
}