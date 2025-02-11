variable "listener_arn" {
  description = "ARN del listener del Load Balancer"
  type        = string
}

variable "priority" {
  description = "Prioridad de la regla del listener"
  type        = number
}

# Acciones dinámicas: Lista de acciones
variable "actions" {
  description = "Lista de acciones a realizar en la regla del listener"
  type = list(object({
    type             = string
    target_group_arn = string
    # Puedes añadir más campos si se agregan más tipos de acciones
    # fixed_response = optional(object({
    #   status_code = string
    #   content_type = string
    #   message_body = string
    # }))
  }))
  default = []
}

# Condiciones dinámicas: Lista de condiciones
variable "conditions" {
  description = "Lista de condiciones para la regla del listener"
  type = list(object({
    host_header    = optional(list(string))
    path_pattern   = optional(list(string))
    query_string   = optional(list(object({
      key   = string
      value = string
    })))
  }))
  default = []
}
