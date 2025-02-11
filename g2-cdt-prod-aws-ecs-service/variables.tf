variable "name" {
  description = "El nombre del servicio ECS"
  type        = string
}

variable "cluster" {
  description = "El nombre del clúster ECS"
  type        = string
}

variable "task_definition" {
  description = "La definición de la tarea ECS que se usará en el servicio"
  type        = string
}

variable "desired_count" {
  description = "Número deseado de tareas para ejecutar en el servicio"
  type        = number
}

variable "launch_type" {
  description = "Tipo de lanzamiento para el servicio ECS (EC2 o Fargate)"
  type        = string
}

variable "network_configuration" {
  description = "Configuración de red del servicio ECS"
  type        = object({
    subnets          = list(string)
    security_groups  = list(string)
    assign_public_ip = bool
  })
  default     = null
}

variable "load_balancers" {
  description = "Lista de balanceadores de carga asociados al servicio ECS"
  type        = list(object({
    target_group_arn = string
    container_name   = string
    container_port   = number
  }))
  default     = []
}

variable "tags" {
  description = "Etiquetas opcionales para el servicio ECS"
  type        = map(string)
  default     = {}
}
