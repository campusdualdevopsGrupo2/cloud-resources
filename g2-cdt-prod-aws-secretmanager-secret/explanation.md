Para utilizar este módulo de Terraform con **Terragrunt**, debemos estructurarlo adecuadamente en Terragrunt. A continuación, te mostraré cómo puedes modularizar y configurar el recurso `aws_secretsmanager_secret` usando **Terragrunt** para un entorno reutilizable.

### 1. Estructura de ficheros

La estructura de carpetas para el uso de **Terragrunt** sería algo como esto:

```text
/terraform
  /modules
    /secretsmanager_secret
      main.tf         # Contiene el recurso `aws_secretsmanager_secret`
      variables.tf    # Variables necesarias para el módulo
      outputs.tf      # Outputs opcionales
  /environments
    /dev
      terragrunt.hcl # Configuración de Terragrunt para el entorno dev
    /prod
      terragrunt.hcl # Configuración de Terragrunt para el entorno prod
```

### 2. Módulo `secretsmanager_secret` (igual que en Terraform)

Este módulo de Terraform no cambia. Debes mantener los archivos que hemos creado para el módulo:

#### `main.tf` (módulo)

```hcl
resource "aws_secretsmanager_secret" "secret" {
  name        = var.name
  description = var.description
  tags        = var.tags

  # Si se desea habilitar la rotación automática de secretos
  rotation_lambda_arn  = var.rotation_lambda_arn
  rotation_rules {
    automatically_after_days = var.rotation_period_days
  }
}
```

#### `variables.tf` (módulo)

```hcl
# Nombre del secreto en Secrets Manager
variable "name" {
  description = "El nombre del secreto en AWS Secrets Manager"
  type        = string
}

# Descripción del secreto
variable "description" {
  description = "Descripción del secreto"
  type        = string
  default     = "Este es un secreto administrado por Terraform"
}

# Etiquetas para el secreto
variable "tags" {
  description = "Etiquetas para el secreto"
  type        = map(string)
  default     = {}
}

# ARN de la función Lambda para la rotación del secreto
variable "rotation_lambda_arn" {
  description = "ARN de la función Lambda para rotación del secreto"
  type        = string
  default     = ""
}

# Periodo de rotación del secreto en días
variable "rotation_period_days" {
  description = "Número de días después del cual se rotará el secreto"
  type        = number
  default     = 30
}
```

#### `outputs.tf` (módulo)

```hcl
output "secret_arn" {
  description = "ARN del secreto creado en AWS Secrets Manager"
  value       = aws_secretsmanager_secret.secret.arn
}

output "secret_name" {
  description = "Nombre del secreto creado en AWS Secrets Manager"
  value       = aws_secretsmanager_secret.secret.name
}
```

### 3. Configuración de Terragrunt

Ahora, creamos la configuración de **Terragrunt** para usar este módulo de manera flexible en diferentes entornos. Para eso, necesitamos un archivo `terragrunt.hcl` para cada entorno que desee usar el módulo.

#### Ejemplo de configuración para el entorno **`dev`**: `environments/dev/terragrunt.hcl`

```hcl
terraform {
  source = "../../modules/secretsmanager_secret"  # Ruta al módulo
}

inputs = {
  name              = "dev-secret"                     # Nombre del secreto
  description       = "Secreto para el entorno de desarrollo"
  tags = {
    "Environment" = "dev"
    "Project"     = "my-app"
  }
  rotation_lambda_arn = "arn:aws:lambda:us-west-2:123456789012:function:rotate-secret"  # ARN de la Lambda para rotación
  rotation_period_days = 30  # Rotación cada 30 días
}
```

#### Ejemplo de configuración para el entorno **`prod`**: `environments/prod/terragrunt.hcl`

```hcl
terraform {
  source = "../../modules/secretsmanager_secret"  # Ruta al módulo
}

inputs = {
  name              = "prod-secret"                     # Nombre del secreto
  description       = "Secreto para el entorno de producción"
  tags = {
    "Environment" = "prod"
    "Project"     = "my-app"
  }
  rotation_lambda_arn = "arn:aws:lambda:us-west-2:123456789012:function:rotate-secret"  # ARN de la Lambda para rotación
  rotation_period_days = 30  # Rotación cada 30 días
}
```

### 4. Ejemplo de ejecución de Terragrunt

Una vez que hayas configurado los archivos `terragrunt.hcl` en los entornos, puedes aplicar la configuración de cada entorno de forma independiente usando los siguientes comandos.

#### Para el entorno `dev`:

```bash
cd environments/dev
terragrunt apply
```

#### Para el entorno `prod`:

```bash
cd environments/prod
terragrunt apply
```

### 5. Variables en la Configuración Principal

En este caso, las variables necesarias para la configuración principal (en cada entorno) son las mismas que las que defines para invocar el módulo. Las variables son proporcionadas a través del archivo `inputs` en el `terragrunt.hcl`, como se muestra en los ejemplos anteriores.

### 6. Outputs de Terragrunt

Puedes imprimir los outputs de este módulo utilizando la siguiente configuración en el `terragrunt.hcl`:

```hcl
output "secret_arn" {
  value = module.secretsmanager_secret.secret_arn
}

output "secret_name" {
  value = module.secretsmanager_secret.secret_name
}
```

### 7. Resumen

- **Módulo de Terraform**: El módulo `secretsmanager_secret` se mantiene igual, gestionando la creación del secreto en AWS Secrets Manager, incluida la rotación automática.
- **Terragrunt**: La configuración de **Terragrunt** en cada entorno (`dev` y `prod`) proporciona las variables necesarias para crear el secreto de forma flexible. El archivo `terragrunt.hcl` en cada entorno maneja los valores específicos como el nombre del secreto, la descripción y las etiquetas.
- **Reusabilidad**: Al utilizar **Terragrunt** de esta manera, puedes gestionar entornos múltiples (por ejemplo, `dev` y `prod`) utilizando el mismo módulo de Terraform, pasando diferentes configuraciones sin duplicar código.

Este enfoque facilita la gestión y reutilización de recursos de AWS en diferentes entornos sin tener que mantener configuraciones separadas, lo cual es una de las principales ventajas de usar **Terragrunt**.