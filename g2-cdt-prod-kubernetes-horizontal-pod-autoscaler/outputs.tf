output "hpa_name" {
  description = "Nombre del Horizontal Pod Autoscaler creado"
  value       = kubernetes_horizontal_pod_autoscaler.this.metadata[0].name
}

output "min_replicas" {
  description = "Número mínimo de réplicas configurado"
  value       = kubernetes_horizontal_pod_autoscaler.this.spec[0].min_replicas
}

output "max_replicas" {
  description = "Número máximo de réplicas configurado"
  value       = kubernetes_horizontal_pod_autoscaler.this.spec[0].max_replicas
}
