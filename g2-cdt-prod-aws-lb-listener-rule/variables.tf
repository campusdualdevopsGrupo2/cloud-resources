variable "listener_arn" {
  description = "ARN del Listener al que se le aplicará la regla"
  type        = string
}

variable "priority" {
  description = "Prioridad de la regla (número entero)"
  type        = number
}

variable "action_type" {
  description = "Tipo de acción para la regla (por ejemplo, 'forward')"
  type        = string
  default     = "forward"
}

variable "action_target_group_arn" {
  description = "ARN del Target Group para la acción de la regla"
  type        = string
}

variable "host_header_values" {
  description = "Lista de valores para la condición host_header"
  type        = list(string)
}
