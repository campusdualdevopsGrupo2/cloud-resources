# ecs_service/main.tf
resource "aws_ecs_service" "ecs_service" {
  name            = var.name
  cluster         = var.cluster
  task_definition = var.task_definition
  desired_count   = var.desired_count
  launch_type     = var.launch_type
  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  tags = var.tags
}

# Outputs del módulo


