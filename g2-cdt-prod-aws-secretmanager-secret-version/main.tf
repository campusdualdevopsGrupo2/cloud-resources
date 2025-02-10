# Recurso para crear una versión de un secreto en AWS Secrets Manager
resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = var.secret_id
  secret_string = var.secret_string

  # Si quieres almacenar un archivo binario, usa `secret_binary`
  # secret_binary = base64encode(var.secret_binary)

  version_stages = var.version_stages
}
