mock_provider "aws" {}

override_data {
  target = data.aws_availability_zones.available
  values = {
    names = ["us-east-1a", "us-east-1b"]
  }
}

variables {
  vpc_name             = "unit-test-vpc"
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  tags = {
    Environment = "unit"
  }
}

###############################################
# Test 1: Minimal VPC Creation
###############################################
run "minimal_vpc" {
  command = plan

  variables {
    public_subnet_cidrs  = ["10.0.1.0/24"]
    private_subnet_cidrs = ["10.0.2.0/24"]
  }

  assert {
    condition     = module.vpc.vpc_id != ""
    error_message = "VPC was not created"
  }

  assert {
    condition     = length(module.vpc.public_subnet_ids) == 1
    error_message = "Expected 1 public subnet"
  }

  assert {
    condition     = length(module.vpc.private_subnet_ids) == 1
    error_message = "Expected 1 private subnet"
  }
}

###############################################
# Test 2: Multi-AZ Deployment
###############################################
run "multi_az" {
  command = plan

  assert {
    condition     = length(module.vpc.public_subnet_ids) == 2
    error_message = "Expected 2 public subnets"
  }

  assert {
    condition     = length(module.vpc.private_subnet_ids) == 2
    error_message = "Expected 2 private subnets"
  }
}

###############################################
# Test 3: NAT Gateway Logic
###############################################
run "single_nat_gateway" {
  command = plan

  assert {
    condition     = length(module.vpc.nat_gateway_ids) == 1
    error_message = "Expected a single NAT gateway"
  }
}

run "multi_nat_gateway" {
  command = plan

  variables {
    single_nat_gateway = false
  }

  assert {
    condition     = length(module.vpc.nat_gateway_ids) == 2
    error_message = "Expected 2 NAT gateways (one per AZ)"
  }
}

###############################################
# Test 4: NAT Disabled
###############################################
run "nat_disabled" {
  command = plan

  variables {
    enable_nat_gateway = false
  }

  assert {
    condition     = length(module.vpc.nat_gateway_ids) == 0
    error_message = "NAT gateways should not be created"
  }
}

###############################################
# Test 5: Validation Tests
###############################################
run "invalid_cidr" {
  command = plan
  expect_failures = [vpc_cidr]

  variables {
    vpc_cidr = "not-a-cidr"
  }
}

run "az_mismatch" {
  command = plan
  expect_failures = [public_subnet_cidrs]

  variables {
    public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  }
}

###############################################
# Test 6: Tagging
###############################################
run "tags" {
  command = plan

  assert {
    condition     = contains(keys(module.vpc.tags), "Environment")
    error_message = "Environment tag missing"
  }
}
