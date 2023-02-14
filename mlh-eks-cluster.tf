provider "kubernetes" {
    
  # Configuring the Kubernetes provider with the cluster endpoint, CA certificate, and authentication token
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.mlh-eks-cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.mlh-eks-cluster.token

}
  
data "aws_eks_cluster" "mlh-eks-cluster" {
  # Retrieving information about the EKS cluster with the name "mlh-eks-cluster"
  name = "mlh-eks-cluster"
}

data "aws_eks_cluster_auth" "mlh-eks-cluster" {
  # Retrieving the authentication token for the EKS cluster with the name "mlh-eks-cluster"
  name = "mlh-eks-cluster"
}

module "eks" {
  # Creating an EKS cluster using the Terraform module "terraform-aws-modules/eks/aws"
  source  = "terraform-aws-modules/eks/aws"
  version = "19.7.0"
  
  # Setting the name and version of the EKS cluster
  cluster_name = "mlh-eks-cluster"
  cluster_version = "1.21"

  # Setting the VPC and subnet IDs for the EKS cluster
  subnet_ids = module.mlh_vpc.private_subnets
  vpc_id = module.mlh_vpc.vpc_id
  
  # Setting tags for the EKS cluster
  tags = {
    Environment = "dev"
    application = "mlh"
  }

  # Creating an EKS managed node group for the "dev" environment
  eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 3
      desired_size = 3

      # Setting the instance types for the EKS managed node group
      instance_types = ["t2.micro"]
    }
  }
}
