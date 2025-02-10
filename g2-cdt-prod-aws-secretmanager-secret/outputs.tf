# Output para el ARN del secreto creado
output "secret_arn" {
  description = "ARN del secreto en Secrets Manager"
  value       = aws_secretsmanager_secret.secret.arn
}

# Output para el nombre del secreto creado
output "secret_name" {
  description = "Nombre del secreto en Secrets Manager"
  value       = aws_secretsmanager_secret.secret.name
}

# Output para el ID del secreto creado
output "secret_id" {
  description = "ID del secreto en Secrets Manager"
  value       = aws_secretsmanager_secret.secret.id
}
