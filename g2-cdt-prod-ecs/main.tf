
# Recurso ECS con variables
resource "aws_ecs_cluster" "mi_ecs" {
  name = "${var.tag_value}-cluster"
  
  setting {
    name  = "containerInsights"
    value = "disabled"
  }

  tags = {
    Team = "Devops-bootcamp-${var.tag_value}"
  }
}

