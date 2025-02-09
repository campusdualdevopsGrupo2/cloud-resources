variable "provider_region" {
  description = "Región del provider AWS"
  type        = string
}

variable "tag_value" {
  description = "Valor utilizado para personalizar nombres y etiquetas"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará el EKS"
  type        = string
}

variable "subnets" {
  description = "Lista de IDs de subnets para el EKS"
  type        = list(string)
}

variable "cluster_version" {
  description = "Versión del cluster EKS"
  type        = string
  default     = "1.32"
}

variable "cluster_endpoint_public_access" {
  description = "Permitir acceso público al endpoint del cluster"
  type        = bool
  default     = true
}

variable "cluster_endpoint_private_access" {
  description = "Permitir acceso privado al endpoint del cluster"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Etiquetas para asignar al cluster y recursos asociados"
  type        = map(string)
  default     = {}
}

variable "cluster_name_prefix" {
  description = "Prefijo para el nombre del cluster"
  type        = string
  default     = "mi-cluster"
}

variable "node_group_config" {
  description = "Configuración de los grupos de nodos administrados"
  type = map(object({
    desired_size   = number
    min_size       = number
    max_size       = number
    instance_types = list(string)
  }))
  default = {
    "mi-nodo-grupo" = {
      desired_size   = 2
      min_size       = 1
      max_size       = 3
      instance_types = [ "t3.small" ]
    }
  }
}

variable "cluster_enabled_log_types" {
  description = "Lista de tipos de logs a habilitar en el cluster (ejemplo: api, audit, authenticator)"
  type        = list(string)
  default     = []
}

variable "repository_name" {
  description = "ECR repository name"
  type        = string
}



variable "policy_sid" {
  description = "SID para la política de ECR"
  type        = string
  default     = "new policy"
}

variable "policy_principals" {
  description = "Lista de identificadores (ARNs) para el principal de la política"
  type        = list(string)
  default     = [
    "arn:aws:sts::248189943700:assumed-role/AWSReservedSSO_EKS-alumnos_a4561514b13725b0/jorge.vidal@campusdual.com"
  ]
}

variable "policy_actions" {
  description = "Lista de acciones permitidas en la política de ECR"
  type        = list(string)
  default     = [
    "ecr:GetDownloadUrlForLayer",
    "ecr:BatchGetImage",
    "ecr:BatchCheckLayerAvailability",
    "ecr:PutImage",
    "ecr:InitiateLayerUpload",
    "ecr:UploadLayerPart",
    "ecr:CompleteLayerUpload",
    "ecr:DescribeRepositories",
    "ecr:GetRepositoryPolicy",
    "ecr:ListImages",
    "ecr:DeleteRepository",
    "ecr:BatchDeleteImage",
    "ecr:SetRepositoryPolicy",
    "ecr:DeleteRepositoryPolicy"
  ]
}
