# Variable para el ID del secreto en Secrets Manager
variable "secret_id" {
  description = "ID del secreto en Secrets Manager"
  type        = string
}

# Variable para el contenido del secreto (en texto plano)
variable "secret_string" {
  description = "El contenido del secreto en texto plano"
  type        = string
}

# Variable para el contenido binario del secreto (si es necesario)
# variable "secret_binary" {
#   description = "El contenido binario del secreto (opcional)"
#   type        = string
#   default     = ""
# }

# Variable para las versiones del secreto (opcional)
variable "version_stages" {
  description = "Las etapas de la versión del secreto"
  type        = list(string)
  default     = ["AWSCURRENT"]
}
