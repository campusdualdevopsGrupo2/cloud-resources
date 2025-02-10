Para modularizar el recurso `data "template_file" "generic_manifest"` y `resource "kubernetes_manifest" "generic_deployment"` de manera eficiente y flexible utilizando **Terragrunt**, la estructura general sigue una metodología de pasar variables de configuración a los módulos. Aquí te muestro cómo hacerlo paso a paso.

### Estructura de ficheros

La estructura será similar a la que propones, pero con la inclusión de **Terragrunt** para gestionar los entornos y parámetros específicos.

```text
/terraform
  /modules
    /k8s_manifest_deployment
      main.tf         # Contiene los recursos `data.template_file` y `kubernetes_manifest`
      variables.tf    # Variables necesarias para el módulo
      outputs.tf      # Outputs opcionales
  /environments
    /dev
      terragrunt.hcl # Configuración de Terragrunt para el entorno dev
    /prod
      terragrunt.hcl # Configuración de Terragrunt para el entorno prod
```

### 1. Módulo `k8s_manifest_deployment`

Este módulo gestionará el recurso `template_file` y `kubernetes_manifest` para crear despliegues de Kubernetes de forma flexible.

#### `main.tf` (módulo)

```hcl
# Definir el recurso de `template_file` para cargar el manifiesto de Kubernetes.
data "template_file" "generic_manifest" {
  template = file(var.manifest_yaml)

  vars = {
    name = var.manifest_name
  }
}

# Recurso para aplicar el manifiesto de Kubernetes
resource "kubernetes_manifest" "generic_deployment" {
  manifest = yamldecode(data.template_file.generic_manifest.rendered)

  # Especifica el proveedor adecuado para el clúster de Kubernetes
  provider = kubernetes.${var.kubernetes_context}
}
```

#### `variables.tf` (módulo)

Este archivo contiene las variables necesarias para el módulo.

```hcl
# Ruta al archivo YAML del manifiesto de Kubernetes
variable "manifest_yaml" {
  description = "Ruta al archivo YAML del manifiesto de Kubernetes"
  type        = string
}

# Nombre que se reemplazará en el manifiesto
variable "manifest_name" {
  description = "El nombre del manifiesto a reemplazar en el template"
  type        = string
}

# Contexto de Kubernetes para elegir el proveedor adecuado
variable "kubernetes_context" {
  description = "El contexto de Kubernetes que se debe usar"
  type        = string
}
```

#### `outputs.tf` (módulo)

Aunque el recurso `kubernetes_manifest` no tiene un ID directo o ARN, podemos exponer algunos valores útiles.

```hcl
# Output del manifiesto renderizado (por ejemplo, el contenido YAML generado)
output "rendered_manifest" {
  description = "El manifiesto renderizado con las variables"
  value       = data.template_file.generic_manifest.rendered
}

# Output para el nombre del manifiesto
output "deployment_name" {
  description = "Nombre del deployment que se aplica"
  value       = var.manifest_name
}
```

### 2. Uso del Módulo en la Configuración Principal

La configuración principal ahora utilizará **Terragrunt** para pasar las variables y manejar diferentes entornos de despliegue.

#### `main.tf` (configuración principal)

Este es el archivo de Terraform donde utilizas el módulo `k8s_manifest_deployment`.

```hcl
module "k8s_deployment" {
  source = "./modules/k8s_manifest_deployment"  # Ruta al módulo

  manifest_yaml     = var.manifest_yaml    # Ruta del archivo YAML
  manifest_name     = var.manifest_name    # Nombre para reemplazar en el template
  kubernetes_context = var.kubernetes_context  # Contexto del clúster de Kubernetes
}

output "deployment_name" {
  value = module.k8s_deployment.deployment_name
}

output "rendered_manifest" {
  value = module.k8s_deployment.rendered_manifest
}
```

#### `variables.tf` (configuración principal)

En este archivo definimos las variables de entrada que se pasarán al módulo, como la ruta del archivo YAML, el nombre del manifiesto y el contexto del clúster de Kubernetes.

```hcl
variable "manifest_yaml" {
  description = "Ruta al archivo YAML del manifiesto de Kubernetes"
  type        = string
}

variable "manifest_name" {
  description = "Nombre que se usará en el manifiesto"
  type        = string
}

variable "kubernetes_context" {
  description = "Contexto de Kubernetes a utilizar"
  type        = string
}
```

### 3. Terragrunt en los Entornos

#### `terragrunt.hcl` (Entorno `dev`)

Aquí definimos las configuraciones específicas del entorno `dev`, que utilizarán el módulo `k8s_manifest_deployment`.

```hcl
terraform {
  source = "../../modules/k8s_manifest_deployment"  # Ruta al módulo
}

inputs = {
  manifest_yaml      = "path/to/your/kubernetes_manifest.yaml"  # Ruta al archivo del manifiesto
  manifest_name      = "dev-deployment"  # Nombre que reemplazará las variables del manifiesto
  kubernetes_context = "dev-k8s-context"  # El contexto del clúster de Kubernetes en dev
}
```

#### `terragrunt.hcl` (Entorno `prod`)

De manera similar, para el entorno `prod`, puedes definir las variables que son específicas para ese entorno.

```hcl
terraform {
  source = "../../modules/k8s_manifest_deployment"  # Ruta al módulo
}

inputs = {
  manifest_yaml      = "path/to/your/kubernetes_manifest.yaml"  # Ruta al archivo del manifiesto
  manifest_name      = "prod-deployment"  # Nombre que reemplazará las variables del manifiesto
  kubernetes_context = "prod-k8s-context"  # El contexto del clúster de Kubernetes en prod
}
```

### 4. Ejemplo de Manifiesto YAML (`kubernetes_manifest.yaml`)

Este archivo YAML tiene un marcador de posición `{{name}}` que se reemplazará con el valor de `manifest_name`.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "{{name}}"
spec:
  replicas: 2
  selector:
    matchLabels:
      app: "{{name}}"
  template:
    metadata:
      labels:
        app: "{{name}}"
    spec:
      containers:
        - name: "{{name}}-container"
          image: "nginx:latest"
```

### 5. Resumen

1. **Módulo `k8s_manifest_deployment`**:
   - Usa `data.template_file` para procesar el manifiesto de Kubernetes y reemplazar las variables dinámicamente.
   - Usa `kubernetes_manifest` para aplicar el manifiesto generado al clúster de Kubernetes.
   - Las variables pasadas al módulo incluyen el archivo YAML del manifiesto, el nombre para reemplazar y el contexto del clúster de Kubernetes.

2. **Terragrunt**:
   - Utiliza Terragrunt para gestionar diferentes entornos (`dev`, `prod`, etc.) sin duplicar la lógica.
   - Las variables específicas de cada entorno se pasan a los módulos para que Terraform las use durante la ejecución.

### 6. Ejecución

Para ejecutar el despliegue en el entorno `dev`, por ejemplo, puedes usar los siguientes comandos:

```bash
cd environments/dev
terragrunt apply
```

Y para el entorno `prod`:

```bash
cd environments/prod
terragrunt apply
```

Este enfoque modular te permite gestionar despliegues de Kubernetes de manera flexible y escalable a través de diferentes entornos, reutilizando el mismo código base y adaptándolo a las necesidades específicas de cada entorno.