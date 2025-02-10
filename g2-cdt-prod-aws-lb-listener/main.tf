resource "aws_lb_listener" "this" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol

  # Para HTTPS se requieren ssl_policy y certificate_arn
  ssl_policy      = var.ssl_policy
  certificate_arn = var.certificate_arn

  default_action {
    type             = var.default_action_type
    target_group_arn = var.default_action_target_group_arn
  }
}
