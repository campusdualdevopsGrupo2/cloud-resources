resource "aws_appautoscaling_policy" "this" {
  name               = var.name
  service_namespace  = var.service_namespace
  resource_id        = var.resource_id
  scalable_dimension = var.scalable_dimension
  policy_type        = var.policy_type

  target_tracking_scaling_policy_configuration {
    target_value = var.target_value

    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }

    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
}
