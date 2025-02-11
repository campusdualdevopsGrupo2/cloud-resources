resource "aws_appautoscaling_policy" "this" {
  name               = var.name
  service_namespace  = var.service_namespace
  resource_id        = var.resource_id
  scalable_dimension = var.scalable_dimension
  policy_type        = var.policy_type

  # Configuración para políticas de tipo "Target Tracking"
  dynamic "target_tracking_scaling_policy_configuration" {
    for_each = var.policy_type == "TargetTracking" ? [1] : []
    content {
      target_value = var.target_value

      predefined_metric_specification {
        predefined_metric_type = var.predefined_metric_type
      }

      scale_in_cooldown  = var.scale_in_cooldown
      scale_out_cooldown = var.scale_out_cooldown
    }
  }

  # Configuración para políticas de tipo "Step Scaling"
  dynamic "step_scaling_policy_configuration" {
    for_each = var.policy_type == "StepScaling" ? [1] : []
    content {
      adjustment_type     = var.adjustment_type
      cooldown            = var.cooldown
      metric_interval_lower_bound = var.metric_interval_lower_bound
      metric_interval_upper_bound = var.metric_interval_upper_bound
      steps {
        metric_interval_lower_bound = var.metric_interval_lower_bound
        metric_interval_upper_bound = var.metric_interval_upper_bound
        scaling_adjustment        = var.scaling_adjustment
      }
    }
  }
}

