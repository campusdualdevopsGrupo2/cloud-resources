# modules/kubernetes_deployment/variables.tf

variable "name" {
  description = "El nombre del Deployment"
  type        = string
}

variable "namespace" {
  description = "El namespace donde se creará el Deployment"
  type        = string
}

variable "labels" {
  description = "Etiquetas del Deployment"
  type        = map(string)
  default     = {}
}

variable "template_labels" {
  description = "Etiquetas para el template del contenedor"
  type        = map(string)
  default     = {}
}

variable "replicas" {
  description = "Número de réplicas del Deployment"
  type        = number
  default     = 1
}

variable "match_labels" {
  description = "Etiquetas de selector para el Deployment"
  type        = map(string)
}

# Contenedores dentro del Deployment
variable "containers" {
  description = "Lista de contenedores para el Deployment"
  type = list(object({
    name  = string
    image = string
    ports = list(number)

    resources = optional(object({
      requests = object({
        cpu    = string
        memory = string
      })
      limits = object({
        cpu    = string
        memory = string
      })
    }))
  }))
  default = []
}

# Volúmenes para el Deployment (opcional)
variable "volumes" {
  description = "Lista de volúmenes para el Deployment"
  type = list(object({
    name        = string
    claim_name  = string
  }))
  default = []
}
