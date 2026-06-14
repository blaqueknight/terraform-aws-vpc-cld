run "full_vpc_deployment" {
  command = plan

  variables {
    vpc_name             = "integration-vpc"
    vpc_cidr             = "10.10.0.0/16"
    availability_zones   = ["us-east-1a", "us-east-1b"]
    public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
    private_subnet_cidrs = ["10.10.101.0/24", "10.10.102.0/24"]

    enable_nat_gateway = true
    single_nat_gateway = true

    tags = {
      Environment = "integration"
    }
  }
}

run "network_connectivity_configuration" {
  command = plan

  variables {
    vpc_name             = "connectivity-vpc"
    vpc_cidr             = "10.20.0.0/16"
    availability_zones   = ["us-east-1a", "us-east-1b"]
    public_subnet_cidrs  = ["10.20.1.0/24", "10.20.2.0/24"]
    private_subnet_cidrs = ["10.20.101.0/24", "10.20.102.0/24"]

    enable_nat_gateway = true
  }
}