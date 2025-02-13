output "repository_name" {
  description = "Nombre del repositorio ECR"
  value       = aws_ecr_repository.repository.name
}

output "repository_url" {
  description = "URL del repositorio ECR"
  value       = aws_ecr_repository.repository.repository_url
}
