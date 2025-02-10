variable "name" {
  description = "Nombre del Horizontal Pod Autoscaler"
  type        = string
}

variable "namespace" {
  description = "Namespace en el que se creará el HPA"
  type        = string
  default     = "default"
}

variable "labels" {
  description = "Etiquetas para el HPA"
  type        = map(string)
  default     = {}
}

variable "scale_target_api_version" {
  description = "API version del objeto que se escalará (por ejemplo, apps/v1)"
  type        = string
}

variable "scale_target_kind" {
  description = "Tipo del recurso que se escalará (por ejemplo, Deployment)"
  type        = string
}

variable "scale_target_name" {
  description = "Nombre del recurso que se escalará"
  type        = string
}

variable "min_replicas" {
  description = "Número mínimo de réplicas"
  type        = number
  default     = 1
}

variable "max_replicas" {
  description = "Número máximo de réplicas"
  type        = number
}

variable "metric_type" {
  description = "Tipo de métrica a usar (por ejemplo, Resource)"
  type        = string
  default     = "Resource"
}

variable "resource_name" {
  description = "Nombre del recurso de la métrica (por ejemplo, cpu)"
  type        = string
  default     = "cpu"
}

variable "target_type" {
  description = "Tipo de objetivo para la métrica (por ejemplo, Utilization)"
  type        = string
  default     = "Utilization"
}

variable "average_utilization" {
  description = "Utilización promedio objetivo en porcentaje (por ejemplo, 50)"
  type        = number
  default     = 50
}
