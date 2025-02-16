module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnets    = module.vpc.public_subnet_ids
}

module "target_group" {
  source           = "./modules/target-group"
  vpc_id           = module.vpc.vpc_id
  alb_arn          = module.alb.alb_arn
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = var.cluster_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  node_instance_type = var.node_instance_type
  desired_capacity   = var.desired_capacity
  min_size           = var.min_size
  max_size           = var.max_size
}

module "alb_controller" {
  source             = "./modules/alb-controller"
  cluster_name       = module.eks.cluster_name
  cluster_arn        = module.eks.cluster_arn
  oidc_provider_arn  = module.eks.oidc_provider_arn
  region             = var.region
}