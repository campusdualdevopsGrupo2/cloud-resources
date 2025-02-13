variable "manifest_yaml" {
  description = "Ruta del archivo YAML del manifiesto de Kubernetes"
  type        = string
}

variable "manifest_name" {
  description = "Nombre que se asignará en el manifiesto (usado en la plantilla)"
  type        = string
}

variable "kubeconfig_path" {
  description = "Ruta al archivo kubeconfig"
  type        = string
  default     = "~/.kube/config"
}

variable "kubeconfig_context" {
  description = "Contexto de Kubernetes dentro del kubeconfig"
  type        = string
}