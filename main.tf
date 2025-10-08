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

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

module "elasticsearch" {
  source           = "./module/elasticsearch"
  eks_cluster_name = var.cluster_name
  namespace        = "logging"
  region           = var.region
  es_storage_size  = var.es_volume_size
  es_replicas      = var.es_instance_count
  kibana_replicas  = var.es_instance_count
  providers = {
  kubernetes = kubernetes
  }
  depends_on = [
  module.eks]
}