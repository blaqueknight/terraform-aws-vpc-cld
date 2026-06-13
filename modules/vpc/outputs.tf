output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "database_subnet_ids" {
  value = module.vpc.database_subnets
}

output "nat_gateways" {
  value = module.vpc.nat_gateways
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr_block
}

output "internet_gateway_id" {
  value = module.vpc.igw_id
}

output "public_route_table_ids" {
  value = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}
