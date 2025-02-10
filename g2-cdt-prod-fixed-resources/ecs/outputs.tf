# Salidas
output "ecs_cluster_id" {
  description = "El ID del clúster ECS creado"
  value       = aws_ecs_cluster.mi_ecs.id
}

output "ecs_cluster_name" {
  description = "El nombre del clúster ECS creado"
  value       = aws_ecs_cluster.mi_ecs.name
}

output "vpc_id" {
  description = "El ID de la VPC donde se encuentra el ECS"
  value       = var.vpc_id
}

output "subnets" {
  description = "Las subnets asociadas al ECS"
  value       = var.subnets
}