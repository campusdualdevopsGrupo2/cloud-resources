output "lambda_function_arn" {
  description = "ARN de la función Lambda creada"
  value       = aws_lambda_function.this.arn
}
