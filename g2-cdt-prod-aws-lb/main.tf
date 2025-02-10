resource "aws_lb" "this" {
  name                       = var.name
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  subnets                    = var.subnets
  security_groups            = var.security_groups
  enable_deletion_protection = var.enable_deletion_protection

  tags = var.tags
}
