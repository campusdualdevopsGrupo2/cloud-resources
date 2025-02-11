¡Con gusto! A continuación te explico cómo usar el recurso de Kubernetes `Horizontal Pod Autoscaler` (HPA) de manera genérica, y cómo estructurarlo con **Terragrunt** para que puedas aplicar configuraciones de forma modular y reutilizable en distintos entornos.

### **Explicación de la Configuración Genérica de HPA**

En la versión genérica del recurso `kubernetes_horizontal_pod_autoscaler`, hemos hecho lo siguiente:

1. **Uso de Bloques Dinámicos**:
   - El bloque `dynamic "metric"` permite definir métricas dinámicamente. Esto significa que no necesitas definir manualmente una métrica fija. Si quieres agregar más métricas, como CPU, memoria, o métricas personalizadas, solo tienes que pasarlas a través de las variables.
   - También se incluye un bloque `dynamic "resource"`, que maneja métricas basadas en recursos como **CPU** o **Memoria** de manera flexible.
   
2. **Parámetros Configurables**:
   - Los parámetros clave del autoscaler, como el nombre del `scale_target` (deployment, statefulset, etc.), el número mínimo y máximo de réplicas (`min_replicas` y `max_replicas`), y las métricas de autoescalado (por ejemplo, **cpu**, **memoria**, **custom metrics**) están todos parametrizados y pueden ser configurados desde el archivo `variables.tf` o por `terragrunt.hcl`.

3. **Flexibilidad**:
   - El autoscaler puede ser configurado tanto con métricas de tipo **recurso** (como CPU o memoria) o métricas **externas** (como métricas personalizadas definidas por el usuario). Esto proporciona una alta flexibilidad.

### **Estructura del Proyecto**

Imagina que tenemos la siguiente estructura de directorios para manejar la infraestructura con **Terraform** y **Terragrunt**:

```
infrastructure/
│
├── modules/
│   └── kubernetes_horizontal_pod_autoscaler/
│       ├── main.tf            # Módulo del Horizontal Pod Autoscaler
│       ├── variables.tf       # Variables del módulo
│       ├── outputs.tf         # Outputs del módulo
│       └── terraform.tfvars   # Valores predeterminados (opcional)
│
└── terragrunt/
    └── dev/
        └── kubernetes_horizontal_pod_autoscaler/
            └── terragrunt.hcl  # Configuración específica para el entorno "dev"
    └── prod/
        └── kubernetes_horizontal_pod_autoscaler/
            └── terragrunt.hcl  # Configuración específica para el entorno "prod"
```

### **1. Definición del Módulo en Terraform**

El módulo que se encuentra en `modules/kubernetes_horizontal_pod_autoscaler/` contiene el código para el recurso HPA. Aquí lo que definimos es el autoscaler flexible con métricas dinámicas.

#### **main.tf del Módulo HPA**

```hcl
# modules/kubernetes_horizontal_pod_autoscaler/main.tf

resource "kubernetes_horizontal_pod_autoscaler" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = var.labels
  }

  spec {
    scale_target_ref {
      api_version = var.scale_target_api_version
      kind        = var.scale_target_kind
      name        = var.scale_target_name
    }

    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    # Definimos métricas dinámicas
    dynamic "metric" {
      for_each = var.metrics
      content {
        type = metric.value.type

        dynamic "resource" {
          for_each = metric.value.type == "Resource" ? [metric.value.resource] : []
          content {
            name = resource.value.name
            target {
              type                = resource.value.target_type
              average_utilization = resource.value.average_utilization
            }
          }
        }

        dynamic "external" {
          for_each = metric.value.type == "External" ? [metric.value.external] : []
          content {
            metric_name = external.value.metric_name
            target_value = external.value.target_value
          }
        }
      }
    }
  }
}
```

#### **variables.tf del Módulo HPA**

```hcl
# modules/kubernetes_horizontal_pod_autoscaler/variables.tf

variable "name" {
  description = "El nombre del Horizontal Pod Autoscaler"
  type        = string
}

variable "namespace" {
  description = "El namespace donde se creará el HPA"
  type        = string
}

variable "labels" {
  description = "Etiquetas para el HPA"
  type        = map(string)
  default     = {}
}

variable "scale_target_api_version" {
  description = "Versión de la API del target"
  type        = string
}

variable "scale_target_kind" {
  description = "Tipo del target (ej. Deployment, StatefulSet)"
  type        = string
}

variable "scale_target_name" {
  description = "Nombre del target"
  type        = string
}

variable "min_replicas" {
  description = "Número mínimo de réplicas"
  type        = number
  default     = 1
}

variable "max_replicas" {
  description = "Número máximo de réplicas"
  type        = number
  default     = 10
}

variable "metrics" {
  description = "Lista de métricas para el autoscaler"
  type = list(object({
    type = string

    resource = optional(object({
      name                = string
      target_type         = string
      average_utilization = optional(number)
    }))
    external = optional(object({
      metric_name = string
      target_value = string
    }))
  }))
  default = []
}
```

### **2. Ejemplo de uso con Terragrunt**

Ahora, en los entornos específicos (como **dev** o **prod**), usaremos **Terragrunt** para aplicar esta configuración y pasarle valores específicos para cada entorno.

#### **Estructura de Archivos de Terragrunt**

Dentro del directorio `terragrunt`, tendrás configuraciones específicas para cada entorno. En este caso, definiremos un archivo `terragrunt.hcl` tanto para **dev** como para **prod**.

##### **Ejemplo de `terragrunt.hcl` para el entorno **dev**

```hcl
# terragrunt/dev/kubernetes_horizontal_pod_autoscaler/terragrunt.hcl

terraform {
  source = "../../modules/kubernetes_horizontal_pod_autoscaler"
}

inputs = {
  name                    = "dev-hpa"
  namespace               = "default"
  labels                 = { app = "my-app" }

  scale_target_api_version = "apps/v1"
  scale_target_kind        = "Deployment"
  scale_target_name        = "my-app-deployment"

  min_replicas            = 2
  max_replicas            = 10

  metrics = [
    {
      type = "Resource"
      resource = {
        name                = "cpu"
        target_type         = "Utilization"
        average_utilization = 80
      }
    },
    {
      type = "Resource"
      resource = {
        name                = "memory"
        target_type         = "Utilization"
        average_utilization = 70
      }
    },
    {
      type = "External"
      external = {
        metric_name = "custom_metric"
        target_value = "50"
      }
    }
  ]
}
```

##### **Ejemplo de `terragrunt.hcl` para el entorno **prod**

```hcl
# terragrunt/prod/kubernetes_horizontal_pod_autoscaler/terragrunt.hcl

terraform {
  source = "../../modules/kubernetes_horizontal_pod_autoscaler"
}

inputs = {
  name                    = "prod-hpa"
  namespace               = "default"
  labels                 = { app = "my-app" }

  scale_target_api_version = "apps/v1"
  scale_target_kind        = "Deployment"
  scale_target_name        = "my-app-deployment"

  min_replicas            = 3
  max_replicas            = 15

  metrics = [
    {
      type = "Resource"
      resource = {
        name                = "cpu"
        target_type         = "Utilization"
        average_utilization = 85
      }
    },
    {
      type = "Resource"
      resource = {
        name                = "memory"
        target_type         = "Utilization"
        average_utilization = 80
      }
    },
    {
      type = "External"
      external = {
        metric_name = "custom_metric"
        target_value = "60"
      }
    }
  ]
}
```

### **3. Ejecución con Terragrunt**

Finalmente, para aplicar las configuraciones para cada entorno, solo necesitas ejecutar **Terragrunt** en el directorio correspondiente.

#### Para el entorno **dev**:

```bash
cd terragrunt/dev/kubernetes_horizontal_pod_autoscaler/
terragrunt apply
```

#### Para el entorno **prod**:

```bash
cd terragrunt/prod/kubernetes_horizontal_pod_autoscaler/
terragrunt apply
```

### **Resumen**

#### **Ventajas de este enfoque**:
1. **Flexibilidad**: Puedes definir múltiples métricas (tanto de recursos como externas) sin necesidad de modificar el módulo principal de Terraform.
2. **Reusabilidad**: Puedes

 aplicar el mismo módulo en diferentes entornos (dev, prod, etc.) con configuraciones específicas utilizando **Terragrunt**.
3. **Configuración Modular**: Terragrunt permite que tu configuración sea reutilizable y mantenible entre múltiples entornos, asegurando que los cambios se propagan correctamente sin duplicar configuraciones.

Este enfoque permite gestionar un **Horizontal Pod Autoscaler** de forma genérica y flexible, y a la vez mantiene una estructura modular y reutilizable mediante el uso de **Terragrunt**.