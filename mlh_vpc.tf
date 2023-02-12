
# AWS provider block
# This block specifies the AWS provider and the region that Terraform will use to manage the infrastructure.

provider "aws" {
    region = "ap-south-1"
  
}

# VPC CIDR block variable
# This variable allows you to specify the CIDR block for the VPC. 

variable "vpc_cidr_block" {
  
}

# Private subnet CIDR blocks variable
# This variable allows you to specify the CIDR blocks for the private subnets.

variable "private_subnet_cidr_blocks" {
  
}

# Public subnet CIDR blocks variable
# This variable allows you to specify the CIDR blocks for the public subnets.

variable "public_subnet_cidr_blocks" {
  
}

# AWS availability zones data block
# This data block retrieves the available availability zones for the specified region.

data "aws_availability_zones" "azs" {

  
}

# VPC module block
# This module block specifies the VPC and its components , that will be created and managed by Terraform.

module "mlh_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"


    # VPC name
    # This is the name of the VPC that will be created.
    name = "mlh-vpc"

    # VPC CIDR block
    # This is the CIDR block for the VPC, specified using the vpc_cidr_block variable.
    cidr = var.vpc_cidr_block

    # Private subnets and public subnets
    # This is the list of private subnets and public subnets, specified using the private_subnet_cidr_blocks variable and the public_subnet_cidr_blocks variable.
 
    private_subnets = var.private_subnet_cidr_blocks
    public_subnets = var.public_subnet_cidr_blocks

    # Availability zones
    # This is the list of availability zones, retrieved from the data block.

    azs = data.aws_availability_zones.azs.names

    # NAT gateway
    # This option enables the creation of a NAT gateway for the private subnets.
    enable_nat_gateway = true
    # Single NAT gateway
    # This option enables the creation of a single NAT gateway for the private subnets.
    single_nat_gateway = true

    # DNS hostnames
    # This option enables the use of DNS hostnames within the VPC.
    enable_dns_hostnames = true


    # VPC tags
    # This is a set of tags that will be associated with the VPC and its components. Helps cloud controller manager to identify the VPC and its components.

    tags = {
        "kubernetes.io/cluster/mlh-eks-cluster" = "shared"


    }

   # Public subnet tags and private subnet tags
   # This is a set of tags that will be associated with the public subnets and private subnets. Helps cloud controller manager to identify the public subnets and private subnets.
    public_subnet_tags = {
        "kubernetes.io/cluster/mlh-eks-cluster" = "shared"
        "kubernetes.io/role/elb" = "1"
    }

    private_subnet_tags = {
        "kubernetes.io/cluster/mlh-eks-cluster" = "shared"
        "kubernetes.io/role/internal-elb" = "1"
    }
}