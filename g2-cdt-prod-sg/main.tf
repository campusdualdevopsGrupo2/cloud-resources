resource "aws_security_group" "this" {
  name   = var.security_group_name
  vpc_id = var.vpc_id

  // Reglas de entrada
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks  = ingress.value.cidr_blocks
      security_groups = ingress.value.security_groups
    }
  }

  // Reglas de salida
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks  = egress.value.cidr_blocks
      security_groups = egress.value.security_groups
    }
  }
}
