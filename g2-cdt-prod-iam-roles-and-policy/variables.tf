/*variable "aws_region" {
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
}*/


# variables.tf

variable "tag_value" {
  description = "Prefijo de nombre para las políticas y roles"
  type        = string
}

variable "assume_role_policy" {
  description = "Política de asunción de rol para el IAM Role"
  type        = any
  default     = {
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  }
}

variable "policy" {
  description = "Política de IAM para el role"
  type        = any
  default     = {
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  }
}

variable "policy_arns" {
  description = "Lista de ARN de políticas para adjuntar al role"
  type        = list(string)
  default     = []
}
