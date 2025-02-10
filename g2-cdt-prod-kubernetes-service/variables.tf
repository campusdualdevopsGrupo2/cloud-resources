variable "name" {
  description = "Nombre del servicio"
  type        = string
}

variable "namespace" {
  description = "Namespace de Kubernetes en el que se creará el servicio"
  type        = string
  default     = "default"
}

variable "labels" {
  description = "Etiquetas del servicio"
  type        = map(string)
  default     = {}
}

variable "selector" {
  description = "Selector de pods para el servicio"
  type        = map(string)
}

variable "service_type" {
  description = "Tipo del servicio (ClusterIP, NodePort, LoadBalancer, etc.)"
  type        = string
  default     = "ClusterIP"
}

variable "port_name" {
  description = "Nombre asignado al puerto"
  type        = string
  default     = "http"
}

variable "port" {
  description = "Puerto expuesto por el servicio"
  type        = number
}

variable "target_port" {
  description = "Puerto del contenedor al que se redirige el tráfico"
  type        = number
}

variable "port_protocol" {
  description = "Protocolo del puerto (TCP, UDP, etc.)"
  type        = string
  default     = "TCP"
}
