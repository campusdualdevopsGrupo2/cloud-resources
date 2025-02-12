variable "repository_name" {
  description = "Nombre del repositorio ECR"
  type        = string
}

variable "tags" {
  description = "Etiquetas para el repositorio ECR"
  type        = map(string)
  default = {
    Project = "Repositorio-grupo-dos"
  }
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

