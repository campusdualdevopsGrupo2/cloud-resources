resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn
  priority     = var.priority

  action {
    type             = var.action_type
    target_group_arn = var.action_target_group_arn
  }

  condition {
    host_header {
      values = var.host_header_values
    }
  }
}
