# ecs_service/variables.tf
variable "name" {
  description = "El nombre del servicio ECS"
  type        = string
}

variable "cluster" {
  description = "El ARN o nombre del clúster de ECS"
  type        = string
}

variable "task_definition" {
  description = "El ARN de la definición de tarea ECS"
  type        = string
}

variable "desired_count" {
  description = "El número deseado de tareas a ejecutar"
  type        = number
  default     = 1
}

variable "launch_type" {
  description = "El tipo de lanzamiento del servicio (FARGATE, EC2)"
  type        = string
  default     = "FARGATE"
}

variable "subnets" {
  description = "Las subredes donde se ejecutará el servicio"
  type        = list(string)
}

variable "security_groups" {
  description = "Los grupos de seguridad asociados al servicio ECS"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Si asignar una IP pública al servicio (para Fargate)"
  type        = bool
  default     = true
}

variable "target_group_arn" {
  description = "ARN del grupo de destino para el balanceador de carga"
  type        = string
}

variable "container_name" {
  description = "El nombre del contenedor en el que se está ejecutando el servicio"
  type        = string
}

variable "container_port" {
  description = "El puerto del contenedor que se expone en el servicio"
  type        = number
}

variable "tags" {
  description = "Etiquetas para el servicio ECS"
  type        = map(string)
  default     = {}
}
