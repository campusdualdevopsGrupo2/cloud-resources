# ecs_task_definition/variables.tf
variable "family" {
  description = "El nombre de la familia de la definición de la tarea de ECS"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN del rol de ejecución de ECS"
  type        = string
}

variable "task_role_arn" {
  description = "ARN del rol de tarea de ECS"
  type        = string
}

variable "network_mode" {
  description = "Modo de red para la definición de tarea (por ejemplo, awsvpc, bridge, host)"
  type        = string
  default     = "awsvpc"
}

variable "cpu" {
  description = "La cantidad de CPU para la tarea (por ejemplo, 256, 512, 1024)"
  type        = string
}

variable "memory" {
  description = "La cantidad de memoria para la tarea (por ejemplo, 512, 1024)"
  type        = string
}

variable "requires_compatibilities" {
  description = "Las compatibilidades necesarias para la tarea (por ejemplo, FARGATE o EC2)"
  type        = list(string)
}

variable "container_definitions" {
  description = "Las definiciones de los contenedores en formato JSON"
  type        = string
}

variable "tags" {
  description = "Etiquetas para la definición de la tarea"
  type        = map(string)
  default     = {}
}
