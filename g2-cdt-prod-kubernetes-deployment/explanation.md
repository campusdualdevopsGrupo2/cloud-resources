### **Explicación del Módulo `kubernetes_deployment` Genérico**

El módulo de **Kubernetes Deployment** que hemos creado es más genérico y flexible gracias al uso de **bloques dinámicos**. Esto permite que puedas configurar una gran variedad de opciones, como múltiples contenedores, puertos, recursos y volúmenes, todo de manera dinámica y configurable a través de variables.

#### **Puntos clave de la configuración**:

1. **Contenedores Dinámicos**:
   - El módulo admite múltiples contenedores dentro de un único `Deployment`. Puedes definir varios contenedores, cada uno con su propia imagen, puertos y recursos.
   - Usamos un bloque `dynamic "container"` para iterar sobre una lista de contenedores definidos en las variables.

2. **Puertos Dinámicos**:
   - Cada contenedor puede tener múltiples puertos definidos. El bloque `dynamic "port"` permite manejar esto de forma dinámica.

3. **Recursos Dinámicos**:
   - Los recursos (CPU y memoria) son opcionales y se añaden solo si se proporcionan. Esto lo gestionamos con el bloque `dynamic "resources"`.

4. **Volúmenes Dinámicos**:
   - Si tu `Deployment` necesita acceder a volúmenes persistentes, puedes añadir volúmenes dinámicamente usando el bloque `dynamic "volume"`. Esto es útil cuando necesitas que el `Deployment` use un **Persistent Volume Claim (PVC)**.

### **Variables del Módulo**:
Las variables permiten que el `Deployment` sea altamente configurable y reutilizable en diferentes entornos y escenarios.

#### **Variables del Módulo**:
- `containers`: Lista de objetos que definen los contenedores del `Deployment`. Cada contenedor tiene atributos como `name`, `image`, `ports`, y `resources`.
- `volumes`: Lista de volúmenes opcionales que pueden ser utilizados por el `Deployment`.
- `replicas`: Número de réplicas para el `Deployment`.
- `labels`: Etiquetas para el `Deployment`.
- `match_labels`: Etiquetas del selector para el `Deployment`.

### **Ejemplo de Uso con Terragrunt**

#### **Estructura de Directorios**:
La estructura de directorios se mantendrá modular, permitiendo que el módulo se pueda reutilizar en diferentes entornos (`dev`, `prod`, etc.).

```
infrastructure/
│
├── modules/
│   └── kubernetes_deployment/
│       ├── main.tf            # Módulo del Deployment
│       ├── variables.tf       # Variables del módulo
│       └── outputs.tf         # Outputs del módulo
│
└── terragrunt/
    ├── dev/
    │   └── kubernetes_deployment/
    │       └── terragrunt.hcl  # Configuración específica para el entorno "dev"
    └── prod/
        └── kubernetes_deployment/
            └── terragrunt.hcl  # Configuración específica para el entorno "prod"
```

### **Ejemplo de Terragrunt para el Entorno `dev`**

El archivo `terragrunt.hcl` para el entorno **dev** puede tener la siguiente configuración.

#### **terragrunt/dev/kubernetes_deployment/terragrunt.hcl**:

```hcl
# terragrunt/dev/kubernetes_deployment/terragrunt.hcl

terraform {
  source = "../../modules/kubernetes_deployment"
}

inputs = {
  name        = "dev-deployment"
  namespace   = "default"
  labels      = { app = "my-app-dev" }
  template_labels = { app = "my-app-template" }

  replicas    = 2
  match_labels = { app = "my-app-dev" }

  containers = [
    {
      name  = "container-1"
      image = "nginx:latest"
      ports = [80, 443]
      resources = {
        requests = {
          cpu    = "500m"
          memory = "256Mi"
        }
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    },
    {
      name  = "container-2"
      image = "redis:latest"
      ports = [6379]
    }
  ]
  
  volumes = [
    {
      name       = "my-volume"
      claim_name = "dev-pvc"
    }
  ]
}
```

### **Explicación de la Configuración de Terragrunt**:

- **Contenedores**: En este caso, se definen dos contenedores:
  - El primero usa la imagen `nginx:latest` y tiene dos puertos (`80` y `443`), además se configuran recursos (`requests` y `limits`).
  - El segundo usa la imagen `redis:latest` con un solo puerto (`6379`).
  
- **Volúmenes**: Se incluye un volumen llamado `my-volume` que está asociado a un **Persistent Volume Claim (PVC)** llamado `dev-pvc`.

- **Replicas**: El número de réplicas del `Deployment` se establece en `2`.

- **Etiquetas**: Se configuran tanto etiquetas en el `Deployment` como etiquetas en el `template` del contenedor para asegurarse de que se alinean con las convenciones de la aplicación.

### **Ejemplo de Terragrunt para el Entorno `prod`**

Un archivo de configuración similar se puede usar para el entorno **prod**, donde se ajustan los valores para el entorno de producción.

#### **terragrunt/prod/kubernetes_deployment/terragrunt.hcl**:

```hcl
# terragrunt/prod/kubernetes_deployment/terragrunt.hcl

terraform {
  source = "../../modules/kubernetes_deployment"
}

inputs = {
  name        = "prod-deployment"
  namespace   = "default"
  labels      = { app = "my-app-prod" }
  template_labels = { app = "my-app-template" }

  replicas    = 5
  match_labels = { app = "my-app-prod" }

  containers = [
    {
      name  = "container-1"
      image = "nginx:latest"
      ports = [80, 443]
      resources = {
        requests = {
          cpu    = "500m"
          memory = "256Mi"
        }
        limits = {
          cpu    = "2"
          memory = "1Gi"
        }
      }
    },
    {
      name  = "container-2"
      image = "redis:latest"
      ports = [6379]
    }
  ]
  
  volumes = [
    {
      name       = "prod-volume"
      claim_name = "prod-pvc"
    }
  ]
}
```

### **Explicación de la Configuración para el Entorno `prod`**:

- **Replicas**: En el entorno de producción, el número de réplicas se aumenta a `5` para manejar más tráfico y asegurar la disponibilidad.
- **Contenedores**: El contenedor `nginx` tiene los mismos puertos, pero los recursos de CPU y memoria son más altos en producción (`cpu` límite de `2` y `memory` de `1Gi`).
- **Volúmenes**: Se cambia el volumen asociado al `PVC` de producción (`prod-pvc`).

### **Despliegue con Terragrunt**

Para aplicar la configuración en los respectivos entornos, solo necesitas ejecutar **Terragrunt** en los directorios correspondientes.

#### Para el entorno **dev**:

```bash
cd terragrunt/dev/kubernetes_deployment
terragrunt apply
```

#### Para el entorno **prod**:

```bash
cd terragrunt/prod/kubernetes_deployment
terragrunt apply
```

### **Resumen de Ventajas**

1. **Modularidad y Reusabilidad**:
   - Al usar **Terragrunt** junto con módulos de **Terraform**, puedes reutilizar la misma infraestructura en diferentes entornos (desarrollo, producción, etc.) con configuraciones específicas para cada uno. Esto permite tener un control centralizado, pero flexible.
   
2. **Configuraciones Dinámicas**:
   - El uso de **bloques dinámicos** para contenedores, puertos, recursos y volúmenes permite una configuración muy flexible, sin tener que modificar el código del módulo cada vez que necesites adaptarlo a nuevos requisitos.
   
3. **Fácil Escalabilidad**:
   - Puedes cambiar la configuración del `Deployment` de manera sencilla ajustando las variables en **Terragrunt**, como el número de réplicas, contenedores, puertos y volúmenes, sin necesidad de reescribir toda la infraestructura.

Este enfoque hace que tu infraestructura sea más modular, escalable y fácil de gestionar, permitiendo adaptarse rápidamente a cambios en la configuración entre diferentes entornos.