variable "manifest_yaml" {
  description = "Ruta del archivo YAML del manifiesto."
  type        = string
}

variable "manifest_name" {
  description = "Nombre del recurso a crear desde el manifiesto."
  type        = string
}

variable "kubernetes_context" {
  description = "El contexto del clúster de Kubernetes a utilizar."
  type        = string
  default     = "default"
}
