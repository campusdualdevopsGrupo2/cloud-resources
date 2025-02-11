resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.family
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  network_mode             = var.network_mode
  cpu                      = var.cpu
  memory                   = var.memory
  requires_compatibilities = var.requires_compatibilities

  # Soporta múltiples contenedores
  container_definitions = jsonencode(var.container_definitions)

  # Opcional: configuraciones de volúmenes
  dynamic "volumes" {
    for_each = var.volumes != null ? var.volumes : []
    content {
      name      = volumes.value.name
      host_path = volumes.value.host_path
    }
  }

  # Soporta las etiquetas
  tags = var.tags
}
