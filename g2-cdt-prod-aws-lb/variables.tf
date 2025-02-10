variable "name" {
  description = "El nombre del Load Balancer"
  type        = string
}

variable "internal" {
  description = "Define si el Load Balancer es interno (true) o público (false)"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Tipo de Load Balancer: 'application', 'network' o 'gateway'"
  type        = string
  default     = "application"
}

variable "subnets" {
  description = "Lista de subnets en las que se creará el Load Balancer"
  type        = list(string)
}

variable "security_groups" {
  description = "Lista de IDs de grupos de seguridad asociados al Load Balancer"
  type        = list(string)
  default     = []
}

variable "enable_deletion_protection" {
  description = "Habilita la protección contra eliminación"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Etiquetas para el Load Balancer"
  type        = map(string)
  default     = {}
}
