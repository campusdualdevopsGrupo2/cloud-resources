output "service_name" {
  description = "Nombre del servicio creado"
  value       = kubernetes_service.this.metadata[0].name
}

output "cluster_ip" {
  description = "Cluster IP asignada al servicio"
  value       = kubernetes_service.this.spec[0].cluster_ip
}
