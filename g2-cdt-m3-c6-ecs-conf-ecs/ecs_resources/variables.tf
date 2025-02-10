variable "tag_value" {
  description = "Tag value for naming resources"
  type        = string
  default= "Grupo2"
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster will be deployed"
  type        = string
  default= "vpc-0c9f03551cb17af5d"
}

variable "subnets" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
  default=["subnet-0399f98a4db137765","subnet-0b0842bc836a4b6cb","subnet-0eb5d5076276d2346"]
}
variable "aws_region" {
  description = "La región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "eu-west-2"  # Valor por defecto para la región (París)
}

variable "custom_flask" {
  type        = string
  default="248189943700.dkr.ecr.eu-west-2.amazonaws.com/repositorio-grupo-dos:custom-flask"
}
variable "custom_nginx" {
  type        = string
  default="248189943700.dkr.ecr.eu-west-2.amazonaws.com/repositorio-grupo-dos:custom-nginx"
}


variable "cluster_id" {
  type= string
  default ="arn:algo"
}

variable "db_username" {
  type = string
  sensitive= true  # Esto marca la variable como sensible
}

variable "db_password" {
  type = string
  sensitive = true  # Esto marca la variable como sensible
}