variable "name" {
  description = "Nombre del Target Group"
  type        = string
}

variable "port" {
  description = "Puerto para el Target Group"
  type        = number
}

variable "protocol" {
  description = "Protocolo para el Target Group (HTTP, HTTPS, TCP, etc.)"
  type        = string
}

variable "vpc_id" {
  description = "ID del VPC donde se creará el Target Group"
  type        = string
}

variable "target_type" {
  description = "Tipo de destino: 'instance', 'ip' o 'lambda'"
  type        = string
  default     = "instance"
}

variable "healthy_threshold" {
  description = "Número de respuestas exitosas para considerar el target saludable"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Número de respuestas fallidas para considerar el target no saludable"
  type        = number
  default     = 3
}

variable "health_check_timeout" {
  description = "Timeout (en segundos) del health check"
  type        = number
  default     = 5
}

variable "health_check_interval" {
  description = "Intervalo (en segundos) entre health checks"
  type        = number
  default     = 30
}

variable "health_check_path" {
  description = "Path para el health check (aplicable para HTTP/HTTPS)"
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "Protocolo del health check (HTTP, HTTPS, etc.)"
  type        = string
  default     = "HTTP"
}

variable "tags" {
  description = "Etiquetas para el Target Group"
  type        = map(string)
  default     = {}
}
