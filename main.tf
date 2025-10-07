provider "aws" {
  region = var.region
}


module "security_group" {
  source        = "./module/security_group"
  vpc_id        = var.vpc_id
  env           = var.env
  ingress_rules = var.ingress_rules
}


module "eks" {
  source              = "./module/eks"
  cluster_name        = var.cluster_name
  cluster_region      = var.region
  node_instance_types = var.node_instance_types
  desired_nodes       = var.desired_nodes
  min_nodes           = var.min_nodes
  max_nodes           = var.max_nodes
  env                 = var.env
  subnet_ids          = var.subnet_ids
  key_name            = var.key_name
  sg_id               = module.security_group.sg_id
  vpc_id              = var.vpc_id
  eks_addons          = var.eks_addons
  external_dns        = var.external_dns
  capacity_type       = var.capacity_type
}


