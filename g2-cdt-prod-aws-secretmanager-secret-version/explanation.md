Para utilizar el módulo `aws_secretsmanager_secret_version` con **Terragrunt**, necesitamos estructurarlo adecuadamente para que se pueda aplicar en diferentes entornos (por ejemplo, `dev`, `prod`, etc.) usando Terragrunt para pasar las variables específicas a cada entorno.

A continuación, te explico cómo estructurar el módulo `secretsmanager_secret_version` de Terraform y cómo configurarlo con **Terragrunt**.

### 1. Estructura de ficheros

La estructura de ficheros sigue un patrón similar al ejemplo anterior, con una carpeta para los módulos y carpetas para cada entorno de Terragrunt.

```text
/terraform
  /modules
    /secretsmanager_secret_version
      main.tf         # Contiene el recurso `aws_secretsmanager_secret_version`
      variables.tf    # Variables necesarias para el módulo
      outputs.tf      # Outputs opcionales
  /environments
    /dev
      terragrunt.hcl # Configuración de Terragrunt para el entorno dev
    /prod
      terragrunt.hcl # Configuración de Terragrunt para el entorno prod
```

### 2. Módulo `secretsmanager_secret_version` (igual que en Terraform)

Este módulo no cambia. Como se mostró en tu ejemplo inicial, el módulo de Terraform para `aws_secretsmanager_secret_version` se mantiene igual.

#### `main.tf` (módulo)

```hcl
resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = var.secret_id
  secret_string = var.secret_string

  # Si quieres almacenar un archivo binario, usa `secret_binary`
  # secret_binary = base64encode(var.secret_binary)

  version_stages = var.version_stages
}
```

#### `variables.tf` (módulo)

```hcl
# ID del secreto de AWS Secrets Manager al cual se le creará una nueva versión
variable "secret_id" {
  description = "El ID del secreto de AWS Secrets Manager al cual se le creará una nueva versión"
  type        = string
}

# Valor del secreto en formato string que se almacenará en la nueva versión
variable "secret_string" {
  description = "El valor del secreto en formato string para almacenar en la nueva versión"
  type        = string
}

# Si quieres almacenar un archivo binario, usa esta variable
# variable "secret_binary" {
#   description = "Archivo binario que se puede almacenar en la versión del secreto"
#   type        = string
#   default     = ""
# }

# Etapas de la versión del secreto, por ejemplo, "AWSCURRENT" o "AWSPREVIOUS"
variable "version_stages" {
  description = "Las etapas de la versión del secreto, como 'AWSCURRENT', 'AWSPREVIOUS'"
  type        = list(string)
  default     = ["AWSCURRENT"]
}
```

#### `outputs.tf` (módulo)

```hcl
output "secret_version_id" {
  description = "ID de la versión del secreto creada en AWS Secrets Manager"
  value       = aws_secretsmanager_secret_version.secret_version.version_id
}

output "secret_arn" {
  description = "ARN del secreto creado en AWS Secrets Manager"
  value       = aws_secretsmanager_secret_version.secret_version.secret_arn
}

output "secret_string" {
  description = "El valor del secreto almacenado en la nueva versión"
  value       = aws_secretsmanager_secret_version.secret_version.secret_string
}
```

### 3. Configuración de Terragrunt para el Entorno

Ahora, configuramos **Terragrunt** para que puedas gestionar diferentes entornos (por ejemplo, `dev`, `prod`) usando el módulo `secretsmanager_secret_version` de manera flexible.

#### Ejemplo de configuración para el entorno `dev`: `environments/dev/terragrunt.hcl`

```hcl
terraform {
  source = "../../modules/secretsmanager_secret_version"  # Ruta al módulo
}

inputs = {
  secret_id     = "arn:aws:secretsmanager:us-west-2:123456789012:secret:my-app-secret-12345"  # ARN del secreto al que se le añadirá una nueva versión
  secret_string = "my-new-secret-value"  # El valor del secreto que se almacenará en la nueva versión
  version_stages = ["AWSCURRENT"]  # Establecer la nueva versión como la actual
}
```

#### Ejemplo de configuración para el entorno `prod`: `environments/prod/terragrunt.hcl`

```hcl
terraform {
  source = "../../modules/secretsmanager_secret_version"  # Ruta al módulo
}

inputs = {
  secret_id     = "arn:aws:secretsmanager:us-west-2:123456789012:secret:my-app-secret-67890"  # ARN del secreto al que se le añadirá una nueva versión
  secret_string = "my-prod-secret-value"  # El valor del secreto que se almacenará en la nueva versión
  version_stages = ["AWSCURRENT"]  # Establecer la nueva versión como la actual
}
```

### 4. Variables en la Configuración Principal

En este caso, las variables necesarias para la configuración principal son las que definimos al invocar el módulo en los archivos `terragrunt.hcl`. Las variables se pasan de la siguiente manera:

#### `variables.tf` (configuración principal)

```hcl
variable "secret_id" {
  description = "ID del secreto de AWS Secrets Manager al cual se le creará una nueva versión"
  type        = string
}

variable "secret_string" {
  description = "El valor del secreto en formato string que se almacenará en la nueva versión"
  type        = string
}

variable "version_stages" {
  description = "Las etapas de la versión del secreto, como 'AWSCURRENT', 'AWSPREVIOUS'"
  type        = list(string)
  default     = ["AWSCURRENT"]
}
```

### 5. Ejemplo de Uso de Terragrunt

Una vez que tengas la configuración de Terragrunt y el módulo de Terraform, puedes aplicar los cambios para crear versiones de secretos en diferentes entornos.

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

### 6. Explicación

1. **`aws_secretsmanager_secret_version`**:
   - Crea una nueva versión de un secreto existente en AWS Secrets Manager utilizando el `secret_id` y el `secret_string` proporcionados.
   - Los `version_stages` pueden ser utilizados para etiquetar la versión, como `AWSCURRENT` para marcar la versión actual.

2. **Variables**:
   - `secret_id`: El ARN del secreto al que se le añadirá una nueva versión. Este valor se puede obtener desde otro módulo o recurso de Terraform.
   - `secret_string`: El nuevo valor del secreto que se almacenará en la nueva versión.
   - `version_stages`: Etapas de la versión que permiten gestionar diferentes versiones del secreto.

3. **Outputs**:
   - `secret_version_id`: El ID de la nueva versión del secreto.
   - `secret_arn`: El ARN del secreto actualizado.
   - `secret_string`: El valor del secreto almacenado en la nueva versión.

### 7. Resumen

Este enfoque modular permite la creación de versiones de secretos en **AWS Secrets Manager** de manera flexible y reutilizable. Al usar **Terragrunt**, puedes gestionar la creación de versiones de secretos en diferentes entornos sin duplicar la lógica, solo variando las configuraciones específicas de cada entorno (por ejemplo, `dev`, `prod`). 

Con este enfoque, puedes controlar de manera eficiente las versiones de los secretos, las etapas de cada versión (como `AWSCURRENT`) y los valores asociados a ellos, todo de forma modular y escalable.