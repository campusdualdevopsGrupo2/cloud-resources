variable "name" {
  description = "Nombre del deployment"
  type        = string
}

variable "namespace" {
  description = "Namespace de Kubernetes para el deployment"
  type        = string
  default     = "default"
}

variable "labels" {
  description = "Etiquetas asignadas al deployment"
  type        = map(string)
  default     = {}
}

variable "replicas" {
  description = "Número de réplicas del deployment"
  type        = number
  default     = 1
}

variable "match_labels" {
  description = "Etiquetas que utilizará el deployment para seleccionar los pods"
  type        = map(string)
}

variable "template_labels" {
  description = "Etiquetas asignadas a los pods creados por el deployment"
  type        = map(string)
}

variable "container_name" {
  description = "Nombre del contenedor"
  type        = string
}

variable "image" {
  description = "Imagen que utilizará el contenedor"
  type        = string
}

variable "container_port" {
  description = "Puerto expuesto por el contenedor"
  type        = number
}
