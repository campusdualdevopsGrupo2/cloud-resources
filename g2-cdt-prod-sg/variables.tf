variable "aws_region" {
  description = "La región de AWS donde se creará el grupo de seguridad."
  type        = string
  default     = "eu-west-2"
}

variable "security_group_name" {
  description = "El nombre del grupo de seguridad."
  type        = string
}

variable "vpc_id" {
  description = "El ID de la VPC donde se creará el grupo de seguridad."
  type        = string
}

variable "egress_rules" {
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)  # Ahora puedes pasar una lista de IDs de SG
  }))
}

variable "ingress_rules" {
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)  # Ahora puedes pasar una lista de IDs de SG
  }))
}