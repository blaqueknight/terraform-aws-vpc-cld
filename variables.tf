variable "region" {
  type        = string
  description = "AWS region to deploy the VPC"
  default     = "us-east-1"
}

variable "name" {
  type        = string
  description = "Name prefix for the VPC"
}

variable "cidr" {
  type        = string
  description = "CIDR block for the VPC"

  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+/\\d+$", var.cidr))
    error_message = "cidr must be a valid IPv4 CIDR, e.g. 10.0.0.0/16."
  }
}

variable "azs" {
  type        = list(string)
  description = "Availability zones to use for subnets"
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDRs for public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDRs for private subnets"
}

variable "database_subnets" {
  type        = list(string)
  description = "CIDRs for database subnets"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Whether to create NAT gateways for private subnets"
  default     = true
}

variable "single_nat_gateway" {
  type        = bool
  description = "Use a single NAT gateway (true) or one per AZ (false)"
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in the VPC"
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support in the VPC"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to VPC resources"
  default     = {}
}