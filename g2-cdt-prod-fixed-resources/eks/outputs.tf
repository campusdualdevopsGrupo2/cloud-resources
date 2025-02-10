output "node_security_group_id" {
  description = "ID of the node shared security group"
  value       = try(module.eks.node_security_group_id, null)
}
output "cluster_name" {

  value       = try(module.eks.cluster_name, null)
}