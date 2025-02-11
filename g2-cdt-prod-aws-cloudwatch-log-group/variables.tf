# Variable para el nombre del Log Group
variable "name" {
  description = "El nombre del grupo de logs en CloudWatch"
  type        = string
}

# Variable para el tiempo de retención de los logs
variable "retention_in_days" {
  description = "Número de días que se conservarán los logs antes de ser eliminados"
  type        = number
  default     = 8 # 30 días por defecto
}

# Variable para las etiquetas del Log Group
variable "tags" {
  description = "Etiquetas para el grupo de logs"
  type        = map(string)
  default     = {}
}
