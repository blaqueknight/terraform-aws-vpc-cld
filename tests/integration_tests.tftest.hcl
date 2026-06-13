###############################################
# Integration Test 1: Full Deployment
###############################################
run "full_deployment" {
  command = apply

  variables {
    name                = "int-test"
    cidr                = "10.10.0.0/16"
    azs                 = ["us-east-1a", "us-east-1b"]
    public_subnets      = ["10.10.1.0/24", "10.10.2.0/24"]
    private_subnets     = ["10.10.3.0/24", "10.10.4.0/24"]
    database_subnets    = ["10.10.5.0/24", "10.10.6.0/24"]
    enable_nat_gateway  = true
    single_nat_gateway  = true
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {
      Environment = "integration"
    }
  }

  # Validate outputs exist
  assert {
    condition     = module.vpc.vpc_id != ""
    error_message = "VPC ID output missing"
  }

  assert {
    condition     = length(module.vpc.public_subnets) == 2
    error_message = "Expected 2 public subnets"
  }

  assert {
    condition     = length(module.vpc.private_subnets) == 2
    error_message = "Expected 2 private subnets"
  }

  assert {
    condition     = length(module.vpc.nat_gateways) == 1
    error_message = "Expected 1 NAT gateway"
  }
}

###############################################
# Integration Test 2: Route Table Connectivity
###############################################
run "route_connectivity" {
  command = apply

  variables {
    name                = "rt-test"
    cidr                = "10.20.0.0/16"
    azs                 = ["us-east-1a", "us-east-1b"]
    public_subnets      = ["10.20.1.0/24", "10.20.2.0/24"]
    private_subnets     = ["10.20.3.0/24", "10.20.4.0/24"]
    database_subnets    = ["10.20.5.0/24", "10.20.6.0/24"]
    enable_nat_gateway  = true
    single_nat_gateway  = true
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {}
  }

  # Public route tables must have IGW route
  assert {
    condition     = length(module.vpc.public_route_table_ids) == 2
    error_message = "Expected 2 public route tables"
  }

  # Private route tables must exist
  assert {
    condition     = length(module.vpc.private_route_table_ids) == 2
    error_message = "Expected 2 private route tables"
  }

  # NAT gateway must exist for private subnets
  assert {
    condition     = length(module.vpc.nat_gateways) == 1
    error_message = "Expected 1 NAT gateway for private subnets"
  }
}
