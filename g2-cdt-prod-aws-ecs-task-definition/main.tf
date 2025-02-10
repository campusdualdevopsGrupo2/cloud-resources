# ecs_task_definition/main.tf
resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.family
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  network_mode             = var.network_mode
  cpu                      = var.cpu
  memory                   = var.memory
  requires_compatibilities = var.requires_compatibilities

  container_definitions = jsonencode(var.container_definitions)

  tags = var.tags
}


