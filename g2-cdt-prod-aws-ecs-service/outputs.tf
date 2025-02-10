output "service_name" {
  description = "Nombre del servicio ECS"
  value       = aws_ecs_service.ecs_service.name
}

output "service_arn" {
  description = "ARN del servicio ECS"
  value       = aws_ecs_service.ecs_service.arn
}

output "service_task_definition" {
  description = "La definición de tarea que está siendo utilizada por el servicio ECS"
  value       = aws_ecs_service.ecs_service.task_definition
}