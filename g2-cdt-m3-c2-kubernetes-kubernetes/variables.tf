variable "provider_region" {
  description = "La región de AWS"
  type        = string
}

variable "tag_value" {
  description = "El valor de la etiqueta a aplicar a los recursos"
  type        = string
}

variable "vpc_id" {
  description = "El ID del VPC"
  type        = string
}

variable "subnets" {
  description = "Los IDs de las subnets"
  type        = list(string)
}

variable "cluster_endpoint_public_access" {
  description = "Permitir acceso público al endpoint del clúster"
  type        = bool
}

variable "cluster_endpoint_private_access" {
  description = "Permitir acceso privado al endpoint del clúster"
  type        = bool
}

variable "instance_type" {
  description = "El tipo de instancia a utilizar"
  type        = string
}

variable "eks_managed_node_groups" {
  description = "Configuración de los grupos de nodos gestionados"
  type        = map(any)
}

