output "vpc_id" {
  value = module.aws_vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.aws_vpc.public_subnets
}

output "private_subnet_ids" {
  value = module.aws_vpc.private_subnets
}

output "database_subnet_ids" {
  value = module.aws_vpc.database_subnets
}

output "nat_gateway_ids" {
  value = module.aws_vpc.nat_gateway_ids
}

output "vpc_cidr" {
  value = module.aws_vpc.vpc_cidr_block
}

output "internet_gateway_id" {
  value = module.aws_vpc.igw_id
}

output "public_route_table_ids" {
  value = module.aws_vpc.public_route_table_ids
}

output "private_route_table_ids" {
  value = module.aws_vpc.private_route_table_ids
}
