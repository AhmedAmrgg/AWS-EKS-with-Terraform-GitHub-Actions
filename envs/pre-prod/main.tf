
module "EKS" {
  source     = "../../modules/EKS"
  cluster_name    = var.cluster_name
  subnet_ids      = module.Network.public_subnets
  private_subnets = module.Network.private_subnets
  public_subnets  = module.Network.public_subnets 
}
 
module "Network" {
  source = "../../modules/Network"
  vpc_name                               = var.vpc_name
  vpc_cidr_block                         = var.vpc_cidr_block
  vpc_availability_zones                 = var.vpc_availability_zones
  vpc_public_subnets                     = var.vpc_public_subnets
  vpc_private_subnets                    = var.vpc_private_subnets 
  vpc_create_database_subnet_group       = true
  vpc_create_database_subnet_route_table = true
  vpc_database_subnets                   = var.vpc_database_subnets    
}
 
module "EBS" {
  source = "../../modules/EBS"
  cluster_name      = module.EKS.cluster_name
  cluster_endpoint  = module.EKS.cluster_endpoint
  cluster_ca        = module.EKS.cluster_ca
  cluster_token     = data.aws_eks_cluster_auth.eks_cluster.token
  oidc_provider_arn = module.EKS.oidc_provider_arn
  oidc_provider_url = module.EKS.oidc_provider_url
}
 
# module "ALB" {
#   source = "../../modules/ALB"
#   cluster_name      = module.EKS.cluster_name
#   cluster_endpoint  = module.EKS.cluster_endpoint
#   cluster_ca        = module.EKS.cluster_ca
#   cluster_token     = data.aws_eks_cluster_auth.eks_cluster.token
#   oidc_provider_arn = module.EKS.oidc_provider_arn
#   oidc_provider_url = module.EKS.oidc_provider_url
#   vpc_id            = module.Network.vpc_id
#  }

