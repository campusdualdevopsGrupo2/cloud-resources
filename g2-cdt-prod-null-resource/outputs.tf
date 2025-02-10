output "command_executed" {
  description = "El comando ejecutado por null_resource"
  value       = var.command
}

output "working_directory_used" {
  description = "El directorio de trabajo donde se ejecutó el comando"
  value       = var.working_directory
}