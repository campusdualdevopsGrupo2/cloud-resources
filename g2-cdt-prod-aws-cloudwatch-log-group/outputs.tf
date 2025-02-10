# Output para el ARN del Log Group creado
output "log_group_arn" {
  description = "El ARN del grupo de logs creado"
  value       = aws_cloudwatch_log_group.log_group.arn
}

# Output para el nombre del Log Group creado
output "log_group_name" {
  description = "El nombre del grupo de logs creado"
  value       = aws_cloudwatch_log_group.log_group.name
}
