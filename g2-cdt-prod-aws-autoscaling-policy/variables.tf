variable "name" {
  description = "Nombre de la política de escalado"
  type        = string
}

variable "service_namespace" {
  description = "El namespace del servicio AWS que soporta Application Auto Scaling (ej. ecs, ec2, dynamodb, etc.)"
  type        = string
}

variable "resource_id" {
  description = "El identificador del recurso al que se aplicará la política (ej. 'service/cluster-name/service-name' para ECS)"
  type        = string
}

variable "scalable_dimension" {
  description = "La dimensión escalable (ej. 'ecs:service:DesiredCount')"
  type        = string
}

variable "policy_type" {
  description = "Tipo de política de escalado. Usualmente 'TargetTrackingScaling'"
  type        = string
  default     = "TargetTrackingScaling"
}

variable "target_value" {
  description = "El valor objetivo para la métrica (por ejemplo, 50 para el 50% de utilización)"
  type        = number
}

variable "predefined_metric_type" {
  description = "El tipo de métrica predefinida (ej. 'ECSServiceAverageCPUUtilization')"
  type        = string
}

variable "scale_in_cooldown" {
  description = "Tiempo en segundos de cooldown tras una acción de scale in"
  type        = number
  default     = 300
}

variable "scale_out_cooldown" {
  description = "Tiempo en segundos de cooldown tras una acción de scale out"
  type        = number
  default     = 300
}
