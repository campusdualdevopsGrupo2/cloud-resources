variable "lambda_function_name" {
  description = "Nombre de la función Lambda"
  type        = string
}

variable "s3_bucket" {
  description = "Nombre del bucket S3 donde se encuentra el código de la Lambda"
  type        = string
}

variable "s3_key" {
  description = "Key del objeto en S3 que contiene el código de la Lambda (por ejemplo, 'lambda-code.zip')"
  type        = string
}

variable "runtime" {
  description = "Runtime de la función Lambda (por ejemplo, nodejs14.x)"
  type        = string
  default     = "nodejs14.x"
}

variable "handler" {
  description = "Handler de la función Lambda (por ejemplo, index.handler)"
  type        = string
  default     = "index.handler"
}

