variable "family" {
  description = "El nombre de la familia de la tarea ECS"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN del rol de ejecución de ECS"
  type        = string
  default     = ""
}

variable "task_role_arn" {
  description = "ARN del rol de la tarea ECS"
  type        = string
  default     = ""
}

variable "network_mode" {
  description = "Modo de red para la tarea (bridge, host, awsvpc)"
  type        = string
  default     = "awsvpc"
}

variable "cpu" {
  description = "Cantidad de CPU para la tarea"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Memoria para la tarea"
  type        = string
  default     = "512"
}

variable "requires_compatibilities" {
  description = "Compatibilidades requeridas (EC2, Fargate)"
  type        = list(string)
  default     = ["FARGATE"]
}

variable "container_definitions" {
  description = "Definiciones de contenedores en formato JSON"
  type        = any
}

variable "tags" {
  description = "Etiquetas opcionales para la tarea"
  type        = map(string)
  default     = {}
}

# Volúmenes opcionales
variable "volumes" {
  description = "Lista de volúmenes opcionales para la tarea"
  type        = list(object({
    name      = string
    host_path = string
  }))
  default     = []
}
