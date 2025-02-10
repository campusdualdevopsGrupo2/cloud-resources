variable "aws_region" {
  description = "La región de AWS donde se creará el grupo de seguridad."
  type        = string
  default     = "us-east-1"
}

variable "security_group_name" {
  description = "El nombre del grupo de seguridad."
  type        = string
}

variable "vpc_id" {
  description = "El ID de la VPC donde se creará el grupo de seguridad."
  type        = string
}

variable "ingress_rules" {
  description = "Lista de reglas de entrada para el grupo de seguridad."
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks  = list(string)
  }))
  default = []
}

variable "egress_rules" {
  description = "Lista de reglas de salida para el grupo de seguridad."
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks  = list(string)
  }))
  default = []
}
