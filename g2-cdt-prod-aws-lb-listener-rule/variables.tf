variable "listener_arn" {
  description = "ARN del listener al que se adjuntará la regla"
  type        = string
}

variable "priority" {
  description = "Prioridad de la regla"
  type        = number
  default     = 100
}

variable "actions" {
  description = "Lista de acciones para la regla"
  type = list(object({
    type               = string
    forward            = optional(object({
      target_group_arn = string
      weight           = number
      stickiness       = optional(object({
        enabled  = bool
        duration = number
      }))
    }))
    redirect           = optional(object({
      host        = string
      port        = string
      protocol    = string
      status_code = string
    }))
    fixed_response     = optional(object({
      content_type = string
      message_body = string
      status_code  = string
    }))
    authenticate_cognito = optional(object({
      user_pool_arn       = string
      user_pool_client_id = string
      user_pool_domain    = string
    }))
    authenticate_oidc = optional(object({
      authorization_endpoint = string
      client_id              = string
      client_secret          = string
      issuer                 = string
      token_endpoint         = string
      user_info_endpoint     = string
    }))
  }))
}

variable "conditions" {
  description = "Lista de condiciones para la regla"
  type = list(object({
    host_header       = optional(list(string))
    http_header_name  = optional(string)
    http_header_values = optional(list(string))
    path_pattern      = optional(list(string))
    query_string_key  = optional(string)
    query_string_value = optional(string)
    source_ip         = optional(list(string))
  }))
}

variable "tags" {
  description = "Etiquetas para la regla"
  type        = map(string)
  default     = {}
}
