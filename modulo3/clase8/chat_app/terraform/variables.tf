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

variable "tag_value" {
  description = "Tag value for naming resources"
  type        = string
  default= "Grupo2"
}

variable "ecr_url" {
  description = "direccion del repo ecr"
  type        = string
  default= "248189943700.dkr.ecr.eu-west-2.amazonaws.com/repositorio-grupo-dos"
}