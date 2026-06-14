mock_provider "aws" {}

override_data {
  target = data.aws_availability_zones.available
  values = {
    names = ["us-east-1a", "us-east-1b"]
  }
}

variables {
  vpc_name             = "test_vpc"
  vpc_cidr             = "10.3.0.0/16"
  availability_zones   = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs  = ["10.3.1.0/24", "10.3.2.0/24"]
  private_subnet_cidrs = ["10.3.3.0/24", "10.3.4.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  tags = {
    Environment = "integration"
  }
}

###############################################
# Integration Test 1: Full Deployment
###############################################
run "full_deployment" {
  command = plan

  assert {
    condition     = aws_vpc.test_vpc.id != ""
    error_message = "VPC ID missing"
  }

  assert {
    condition     = length(aws_subnet.test_subnet.id) == 2
    error_message = "Expected 2 public subnets"
  }

  assert {
    condition     = length(aws_vpc.test_vpc.private_subnet_ids) == 2
    error_message = "Expected 2 private subnets"
  }

  assert {
    condition     = length(aws_vpc.test_vpc.nat_gateway_ids) == 1
    error_message = "Expected 1 NAT gateway"
  }

  assert {
    condition     = length(aws_vpc.test_vpc.public_route_table_ids) == 1
    error_message = "Expected 1 public route table"
  }

  assert {
    condition     = length(aws_vpc.test_vpc.private_route_table_ids) == 2
    error_message = "Expected 2 private route tables"
  }
}

###############################################
# Integration Test 2: Connectivity
###############################################
run "connectivity" {
  command = plan

  assert {
    condition     = aws_vpc.test_vpc.internet_gateway_id != ""
    error_message = "Internet Gateway missing"
  }

  assert {
    condition     = length(aws_vpc.test_vpc.nat_gateway_ids) == 1
    error_message = "NAT Gateway missing"
  }
}
