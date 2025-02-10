variable "aws_region" {
  description = "La región de AWS donde se creará el rol de IAM."
  type        = string
  default     = "us-east-1"
}

variable "policy_name" {
  description = "El nombre de la política de IAM."
  type        = string
}

variable "policy_description" {
  description = "Descripción de la política de IAM."
  type        = string
}

variable "policy_document" {
  description = "El documento de la política de IAM en formato JSON."
  type        = string
}


variable "role_name" {
  description = "El nombre del rol de IAM."
  type        = string
}

variable "assume_role_policy" {
  description = "La política de confianza que define quién puede asumir el rol."
  type        = string
}

variable "managed_policy_arns" {
  description = "Lista de ARNs de políticas administradas que se adjuntarán al rol."
  type        = list(string)
  default     = []
}
