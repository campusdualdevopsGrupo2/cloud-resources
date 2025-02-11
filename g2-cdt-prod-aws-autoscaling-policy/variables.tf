# Variables para el módulo
variable "name" {
  description = "Nombre de la política de escalado"
  type        = string
}

variable "service_namespace" {
  description = "El espacio de nombres del servicio (por ejemplo, ecs, dynamodb, etc.)"
  type        = string
}

variable "resource_id" {
  description = "ID del recurso que será escalado"
  type        = string
}

variable "scalable_dimension" {
  description = "Dimensión escalable del recurso (por ejemplo, ecs:service:DesiredCount)"
  type        = string
}

variable "policy_type" {
  description = "Tipo de política de escalado (por ejemplo, TargetTracking o StepScaling)"
  type        = string
}

variable "target_value" {
  description = "Valor objetivo para la política de TargetTracking"
  type        = number
  default     = null
}

variable "predefined_metric_type" {
  description = "Tipo de métrica predefinida para la política de TargetTracking"
  type        = string
  default     = null
}

variable "scale_in_cooldown" {
  description = "Tiempo en segundos para la fase de enfriamiento después de una acción de escalado hacia abajo"
  type        = number
  default     = 300
}

variable "scale_out_cooldown" {
  description = "Tiempo en segundos para la fase de enfriamiento después de una acción de escalado hacia arriba"
  type        = number
  default     = 300
}

variable "adjustment_type" {
  description = "Tipo de ajuste para la política Step Scaling"
  type        = string
  default     = null
}

variable "cooldown" {
  description = "Tiempo en segundos para la fase de enfriamiento después de un ajuste de escalado"
  type        = number
  default     = null
}

variable "metric_interval_lower_bound" {
  description = "Límite inferior del intervalo de la métrica para Step Scaling"
  type        = number
  default     = null
}

variable "metric_interval_upper_bound" {
  description = "Límite superior del intervalo de la métrica para Step Scaling"
  type        = number
  default     = null
}

variable "scaling_adjustment" {
  description = "Ajuste de escalado para Step Scaling"
  type        = number
  default     = null
}
