# Recurso para crear un secreto en AWS Secrets Manager
resource "aws_secretsmanager_secret" "secret" {
  name        = var.name
  description = var.description
  tags        = var.tags

  # Si se desea habilitar la rotación automática de secretos
  rotation_lambda_arn  = var.rotation_lambda_arn
  rotation_rules {
    automatically_after_days = var.rotation_period_days
  }
}

