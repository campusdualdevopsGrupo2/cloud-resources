# variables.tf

# Nombre del servicio Kubernetes
variable "name" {
  description = "El nombre del servicio Kubernetes"
  type        = string
}

# Namespace donde se creará el servicio
variable "namespace" {
  description = "El namespace del servicio Kubernetes"
  type        = string
}

# Etiquetas del servicio Kubernetes
variable "labels" {
  description = "Etiquetas para el servicio Kubernetes"
  type        = map(string)
  default     = {}
}

# Selector para el servicio, generalmente utilizado para seleccionar pods
variable "selector" {
  description = "Selector que identifica los pods para este servicio"
  type        = map(string)
  default     = {}
}

# Tipo del servicio Kubernetes, como LoadBalancer, ClusterIP, o NodePort
variable "service_type" {
  description = "El tipo de servicio Kubernetes (ClusterIP, NodePort, LoadBalancer)"
  type        = string
  default     = "ClusterIP"
}

# Puertos del servicio Kubernetes (puede incluir múltiples puertos)
variable "ports" {
  description = "Lista de puertos para el servicio Kubernetes"
  type = list(object({
    name        = string
    port        = number
    target_port = number
    protocol    = string
  }))
  default = [
    {
      name        = "http"
      port        = 80
      target_port = 8080
      protocol    = "TCP"
    }
  ]
}

# IPs externas (solo se usará si el servicio es de tipo LoadBalancer)
variable "external_ips" {
  description = "Lista de IPs externas para servicios LoadBalancer"
  type        = list(string)
  default     = []
}
