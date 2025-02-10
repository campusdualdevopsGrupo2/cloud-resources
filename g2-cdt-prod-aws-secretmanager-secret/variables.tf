# Variable para el nombre del secreto
variable "name" {
  description = "El nombre del secreto en Secrets Manager"
  type        = string
}

# Variable para la descripción del secreto
variable "description" {
  description = "Descripción del secreto"
  type        = string
  default     = "Secret created via Terraform"
}

# Variable para las etiquetas del secreto
variable "tags" {
  description = "Etiquetas para el secreto"
  type        = map(string)
  default     = {}
}

# Variable para habilitar la rotación automática del secreto
variable "rotation_lambda_arn" {
  description = "ARN de la función Lambda para la rotación del secreto (opcional)"
  type        = string
  default     = ""
}

# Variable para el período de rotación automática del secreto (en días)
variable "rotation_period_days" {
  description = "Número de días entre cada rotación automática del secreto"
  type        = number
  default     = 30
}
