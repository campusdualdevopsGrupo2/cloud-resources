variable "service_namespace" {
  description = "El namespace del servicio AWS que soporta Application Auto Scaling (ej. ecs, ec2, dynamodb, etc.)"
  type        = string
}

variable "resource_id" {
  description = "El identificador del recurso asociado (por ejemplo, 'service/cluster-name/service-name' para ECS)"
  type        = string
}

variable "scalable_dimension" {
  description = "La dimensión escalable del recurso (ej. 'ecs:service:DesiredCount')"
  type        = string
  default= "ecs:service:DesiredCount"
}

variable "min_capacity" {
  description = "La capacidad mínima para el recurso escalable"
  type        = number
  default= 1
}

variable "max_capacity" {
  description = "La capacidad máxima para el recurso escalable"
  type        = number
  default= 3
}

variable "role_arn" {
  description = "ARN del rol IAM a utilizar para el escalado (si es requerido por el servicio)"
  type        = string
  default     = null
}
