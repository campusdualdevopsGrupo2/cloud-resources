# Recurso para crear el Log Group en CloudWatch
resource "aws_cloudwatch_log_group" "log_group" {
  name              = var.name
  retention_in_days = var.retention_in_days
  tags              = var.tags
}

# Añadir una política de eliminación para que se borre cuando se destruye el módulo
resource "aws_cloudwatch_log_group" "log_group" {
  name              = var.name
  retention_in_days = var.retention_in_days
  tags              = var.tags
}

