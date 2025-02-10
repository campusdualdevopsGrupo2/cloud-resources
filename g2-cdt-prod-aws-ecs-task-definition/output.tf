# Outputs del módulo

output "task_definition_arn" {
  description = "ARN de la definición de la tarea de ECS"
  value       = aws_ecs_task_definition.task_definition.arn
}

output "task_definition_revision" {
  description = "Revisión de la definición de la tarea de ECS"
  value       = aws_ecs_task_definition.task_definition.revision
}