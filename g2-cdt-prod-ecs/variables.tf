# Variables para la configuración
variable "tag_value" {
  description = "Valor de la etiqueta que se usará en los recursos"
  type        = string
  default     = "Grupo2"  # Valor predeterminado si no se pasa
}

variable "aws_region" {
  description = "La región de AWS donde se crearán los recursos"
  type        = string
  default     = "eu-west-2"  # Región predeterminada
}

variable "vpc_id" {
  description = "El ID de la VPC donde se creará el ECS"
  type        = string
  default     = "vpc-0c9f03551cb17af5d"  # ID de la VPC predeterminado (VPC por defecto)
}

variable "subnets" {
  description = "Lista de IDs de las subnets asociadas al ECS"
  type        = list(string)
  default     = [
    "subnet-0399f98a4db137765",
    "subnet-0b0842bc836a4b6cb",
    "subnet-0eb5d5076276d2346"
  ]  # Subnets predeterminadas
}