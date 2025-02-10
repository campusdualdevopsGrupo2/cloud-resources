output "deployment_name" {
  description = "Nombre del deployment creado"
  value       = kubernetes_deployment.this.metadata[0].name
}

output "deployment_replicas" {
  description = "Número de réplicas definidas en el deployment"
  value       = kubernetes_deployment.this.spec[0].replicas
}
