module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"
  
  cluster_name    = "mi-cluster-${var.tag_value}"
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnets
  
  # Configuración de acceso público y privado (se puede configurar usando `cluster_endpoint_public_access` y `cluster_endpoint_private_access`)
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access

  eks_managed_node_groups = {
    grupo-nodos = {
      desired_size = var.desired_size
      max_size     = var.max_size
      min_size     = var.min_size

      instance_types = [var.instance_type]

      iam_role_additional_policies = var.iam_role_additional_policies
    }
  }
}


output "node_security_group_id" {
  description = "ID of the node shared security group"
  value       = try(module.eks.node_security_group_id, null)
}
output "cluster_name" {

  value       = try(module.eks.cluster_name, null)
}

/*resource "null_resource" "update_kubeconfig" {
  depends_on = [module.eks]  # Asegura que este recurso se ejecute después de que el clúster EKS se haya creado.

  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_name}"

    environment = {
      AWS_PROFILE = "default" # Si utilizas un perfil específico de AWS
    }
  }
}*/


