provider "aws" {
  region = var.provider_region
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"
 
  cluster_name    = "${var.cluster_name_prefix}-${var.tag_value}"
  cluster_version = var.cluster_version
 
  vpc_id     = var.vpc_id
  subnet_ids = var.subnets

  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access

  tags = var.tags

  eks_managed_node_groups = var.node_group_config

  cluster_enabled_log_types = var.cluster_enabled_log_types
}
