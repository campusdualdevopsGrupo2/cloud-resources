# Output para el ARN de la versión del secreto creada
output "secret_version_arn" {
  description = "ARN de la versión del secreto"
  value       = aws_secretsmanager_secret_version.secret_version.arn
}

# Output para el ID de la versión del secreto
output "secret_version_id" {
  description = "ID de la versión del secreto"
  value       = aws_secretsmanager_secret_version.secret_version.version_id
}
