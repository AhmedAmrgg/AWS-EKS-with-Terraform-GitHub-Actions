terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.7.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 3.0.0"
    }   
  }
}

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host = data.aws_eks_cluster.eks_cluster.endpoint 
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token = data.aws_eks_cluster_auth.eks_cluster.token
}

# data "aws_eks_cluster" "eks_cluster" {
#   name = var.cluster_name
# }

# data "aws_eks_cluster_auth" "eks_cluster" {
#   name = var.cluster_name
#   # depends_on = [module.EKS]
# }
 
provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks_cluster.token
  }
}