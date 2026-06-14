run "minimal_vpc_configuration" {
  command = plan

  variables {
    vpc_name               = "test-vpc"
    vpc_cidr               = "10.0.0.0/16"
    availability_zones     = ["us-east-1a"]
    public_subnet_cidrs    = ["10.0.1.0/24"]
    private_subnet_cidrs   = ["10.0.101.0/24"]
    enable_nat_gateway     = false
    single_nat_gateway     = true
    enable_dns_hostnames   = true
    enable_dns_support     = true

    tags = {
      Environment = "test"
    }
  }
}

run "multi_az_configuration" {
  command = plan

  variables {
    vpc_name             = "multi-az-vpc"
    vpc_cidr             = "10.1.0.0/16"
    availability_zones   = ["us-east-1a", "us-east-1b"]
    public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
    private_subnet_cidrs = ["10.1.101.0/24", "10.1.102.0/24"]

    tags = {
      Environment = "test"
    }
  }
}

run "single_nat_gateway" {
  command = plan

  variables {
    vpc_name             = "nat-test"
    vpc_cidr             = "10.2.0.0/16"
    availability_zones   = ["us-east-1a"]
    public_subnet_cidrs  = ["10.2.1.0/24"]
    private_subnet_cidrs = ["10.2.101.0/24"]

    enable_nat_gateway = true
    single_nat_gateway = true
  }
}

run "nat_gateway_disabled" {
  command = plan

  variables {
    vpc_name             = "no-nat"
    vpc_cidr             = "10.3.0.0/16"
    availability_zones   = ["us-east-1a"]
    public_subnet_cidrs  = ["10.3.1.0/24"]
    private_subnet_cidrs = ["10.3.101.0/24"]

    enable_nat_gateway = false
  }
}

run "tagging_test" {
  command = plan

  variables {
    vpc_name             = "tag-test"
    vpc_cidr             = "10.4.0.0/16"
    availability_zones   = ["us-east-1a"]
    public_subnet_cidrs  = ["10.4.1.0/24"]
    private_subnet_cidrs = ["10.4.101.0/24"]

    tags = {
      Owner       = "Ahmad"
      Environment = "Lab"
      Terraform   = "true"
    }
  }
}