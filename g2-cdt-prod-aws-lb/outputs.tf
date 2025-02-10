output "lb_arn" {
  description = "ARN del Load Balancer"
  value       = aws_lb.this.arn
}

output "lb_dns_name" {
  description = "DNS del Load Balancer"
  value       = aws_lb.this.dns_name
}
