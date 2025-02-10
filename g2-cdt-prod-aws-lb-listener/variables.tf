variable "load_balancer_arn" {
  description = "ARN del Load Balancer al que se asociará el Listener"
  type        = string
}

variable "port" {
  description = "Puerto en el que el Listener escuchará"
  type        = number
}

variable "protocol" {
  description = "Protocolo del Listener (HTTP o HTTPS)"
  type        = string
}

variable "ssl_policy" {
  description = "SSL policy a aplicar (requerido para HTTPS)"
  type        = string
  default     = null
}

variable "certificate_arn" {
  description = "ARN del certificado para HTTPS"
  type        = string
  default     = null
}

variable "default_action_type" {
  description = "Tipo de acción por defecto (por ejemplo: 'forward')"
  type        = string
  default     = "forward"
}

variable "default_action_target_group_arn" {
  description = "ARN del Target Group al que se redirigirá el tráfico en la acción por defecto"
  type        = string
}
