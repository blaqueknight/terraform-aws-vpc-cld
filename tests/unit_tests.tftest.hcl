run "minimal_vpc" {
  command = plan

  variables {
    name                = "test-vpc"
    cidr                = "10.0.0.0/16"
    azs                 = ["us-east-1a"]
    public_subnets      = ["10.0.1.0/24"]
    private_subnets     = ["10.0.2.0/24"]
    database_subnets    = ["10.0.3.0/24"]
    enable_nat_gateway  = true
    single_nat_gateway  = true
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {
      Environment = "test"
    }
  }

  assert {
    condition     = module.vpc.vpc_cidr_block == "10.0.0.0/16"
    error_message = "VPC CIDR block incorrect"
  }
}
run "multi_az" {
  command = plan

  variables {
    name             = "multi"
    cidr             = "10.1.0.0/16"
    azs              = ["us-east-1a", "us-east-1b"]
    public_subnets   = ["10.1.1.0/24", "10.1.2.0/24"]
    private_subnets  = ["10.1.3.0/24", "10.1.4.0/24"]
    database_subnets = ["10.1.5.0/24", "10.1.6.0/24"]
    enable_nat_gateway = true
    single_nat_gateway = false
    enable_dns_hostnames = true
    enable_dns_support   = true
  }

  assert {
    condition     = length(module.vpc.public_subnets) == 2
    error_message = "Expected 2 public subnets"
  }
}
run "nat_single" {
  command = plan

  variables {
    name             = "nat-single"
    cidr             = "10.2.0.0/16"
    azs              = ["us-east-1a"]
    public_subnets   = ["10.2.1.0/24"]
    private_subnets  = ["10.2.2.0/24"]
    database_subnets = ["10.2.3.0/24"]
    enable_nat_gateway = true
    single_nat_gateway = true
  }

  assert {
    condition     = length(module.vpc.nat_gateways) == 1
    error_message = "Expected 1 NAT gateway"
  }
}
run "nat_disabled" {
  command = plan

  variables {
    name             = "nat-off"
    cidr             = "10.4.0.0/16"
    azs              = ["us-east-1a"]
    public_subnets   = ["10.4.1.0/24"]
    private_subnets  = ["10.4.2.0/24"]
    database_subnets = ["10.4.3.0/24"]
    enable_nat_gateway = false
    single_nat_gateway = false
  }

  assert {
    condition     = length(module.vpc.nat_gateways) == 0
    error_message = "NAT gateways should not be created"
  }
}
run "invalid_cidr" {
  command = plan

  variables {
    name             = "bad"
    cidr             = "not-a-cidr"
    azs              = ["us-east-1a"]
    public_subnets   = ["10.5.1.0/24"]
    private_subnets  = ["10.5.2.0/24"]
    database_subnets = ["10.5.3.0/24"]
    enable_nat_gateway = true
    single_nat_gateway = true
  }

  expect_failures = ["cidr"]
}
run "tagging" {
  command = plan

  variables {
    name             = "tag-test"
    cidr             = "10.6.0.0/16"
    azs              = ["us-east-1a"]
    public_subnets   = ["10.6.1.0/24"]
    private_subnets  = ["10.6.2.0/24"]
    database_subnets = ["10.6.3.0/24"]
    enable_nat_gateway = true
    single_nat_gateway = true
    tags = {
      Owner = "Corey"
      Env   = "Dev"
    }
  }

  assert {
    condition     = module.vpc.tags["Owner"] == "Corey"
    error_message = "Tag Owner not applied"
  }
}
