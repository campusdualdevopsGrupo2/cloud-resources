# Nombre del Horizontal Pod Autoscaler
variable "name" {
  description = "El nombre del Horizontal Pod Autoscaler"
  type        = string
}

# Namespace donde se creará el Horizontal Pod Autoscaler
variable "namespace" {
  description = "El namespace donde se creará el Horizontal Pod Autoscaler"
  type        = string
}

# Etiquetas del Horizontal Pod Autoscaler
variable "labels" {
  description = "Etiquetas para el Horizontal Pod Autoscaler"
  type        = map(string)
  default     = {}
}

# Parámetros del target al que se aplicará el autoscaler
variable "scale_target_api_version" {
  description = "La versión de la API del target"
  type        = string
}

variable "scale_target_kind" {
  description = "El tipo de target (ej. Deployment, StatefulSet, etc.)"
  type        = string
}

variable "scale_target_name" {
  description = "El nombre del target"
  type        = string
}

# Mínimo número de réplicas
variable "min_replicas" {
  description = "El número mínimo de réplicas"
  type        = number
  default     = 1
}

# Máximo número de réplicas
variable "max_replicas" {
  description = "El número máximo de réplicas"
  type        = number
  default     = 5
}

# Definición de métricas que usará el autoscaler
variable "metrics" {
  description = "Lista de métricas para el autoscaler"
  type = list(object({
    type = string

    resource = optional(object({
      name                = string
      target_type         = string
      average_utilization = optional(number)
    }))
    external = optional(object({
      metric_name = string
      target_value = string
    }))
  }))
  default = [
    {
      type = "Resource"
      resource = {
        name                = "cpu"
        target_type         = "Utilization"
        average_utilization = 80
      }
    },
    {
      type = "Resource"
      resource = {
        name                = "memory"
        target_type         = "Utilization"
        average_utilization = 75
      }
    }
  ]
}
