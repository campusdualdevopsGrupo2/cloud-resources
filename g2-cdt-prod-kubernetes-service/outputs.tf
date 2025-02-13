# outputs.tf

# El nombre del servicio Kubernetes
output "service_name" {
  description = "El nombre del servicio Kubernetes"
  value       = kubernetes_service.this.metadata[0].name
}

# El namespace del servicio Kubernetes
output "service_namespace" {
  description = "El namespace donde se encuentra el servicio Kubernetes"
  value       = kubernetes_service.this.metadata[0].namespace
}

# Las etiquetas del servicio Kubernetes
output "service_labels" {
  description = "Las etiquetas del servicio Kubernetes"
  value       = kubernetes_service.this.metadata[0].labels
}

# Selector del servicio Kubernetes
output "service_selector" {
  description = "El selector del servicio Kubernetes"
  value       = kubernetes_service.this.spec[0].selector
}

# Tipo de servicio Kubernetes
output "service_type" {
  description = "El tipo de servicio Kubernetes (ClusterIP, LoadBalancer, NodePort)"
  value       = kubernetes_service.this.spec[0].type
}

# Los puertos del servicio Kubernetes
output "service_ports" {
  description = "Los puertos del servicio Kubernetes"
  value       = kubernetes_service.this.spec[0].port
}

# IPs externas del servicio Kubernetes (si se aplica)
output "service_external_ips" {
  description = "Las IPs externas del servicio Kubernetes (si es LoadBalancer)"
  value = kubernetes_service.this.spec[0].type == "LoadBalancer" && length(kubernetes_service.this.spec[0].external_ips) > 0 ? kubernetes_service.this.spec[0].external_ips : []          
}

