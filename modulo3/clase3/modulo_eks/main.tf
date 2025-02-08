module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks_cluster_name
  cluster_version = "1.31"
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

# Configure public and private endpoint access
  cluster_endpoint_public_access = true  # Enable public access
  cluster_endpoint_private_access = true # Disable private access (optional)

  eks_managed_node_groups = {
    my-node-group = {
        desired_size = 2
        max_size = 3
        min_size = 1

        instance_types = ["t3.small"]
    }
  } 
  

}