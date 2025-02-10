variable "repository_name" {
  description = "ECR repository name"
  type        = string
  default="repositorio-grupo-dos"
}


variable "aws_region" {
  description = "La región de AWS donde se desplegarán los recursos"
  type        = string
  default="eu-west-2"
  
}