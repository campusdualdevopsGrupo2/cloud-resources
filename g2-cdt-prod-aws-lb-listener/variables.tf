variable "load_balancer_arn" {
  description = "ARN del Load Balancer al que se asocia el listener"
  type        = string
}

variable "port" {
  description = "El puerto en el que escucha el Load Balancer"
  type        = string
}

variable "protocol" {
  description = "El protocolo para el listener (HTTP, HTTPS)"
  type        = string
}

variable "ssl_policy" {
  description = "La política SSL para HTTPS"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "ARN del certificado SSL para HTTPS"
  type        = string
  default     = ""
}

# Acciones predeterminadas: Lista de acciones
variable "default_actions" {
  description = "Lista de acciones predeterminadas para el listener"
  type = list(object({
    type             = string
    target_group_arn = optional(string)
    fixed_response   = optional(object({
      status_code  = number
      content_type = string
      message_body = string
    }))
    redirect = optional(object({
      status_code = string
      host        = string
      path        = string
      query       = string
      port        = string
      protocol    = string
    }))
  }))
  default = []
}
