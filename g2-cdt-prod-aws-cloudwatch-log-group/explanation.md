Para usar el módulo `cloudwatch_log_group` en **Terragrunt**, el archivo de configuración de Terragrunt (`terragrunt.hcl`) se estructura de manera diferente, pero sigue el mismo principio de modularidad que en Terraform.

Te voy a dar un ejemplo de cómo usar este módulo de Terraform en Terragrunt.

### 1. Estructura de ficheros en Terragrunt

La estructura para organizar el uso del módulo `cloudwatch_log_group` desde Terragrunt sería similar a la siguiente:

```text
/terraform
  /modules
    /cloudwatch_log_group
      main.tf         # Contiene el recurso `aws_cloudwatch_log_group`
      variables.tf    # Variables necesarias para el módulo
      outputs.tf      # Outputs opcionales
  /environments
    /dev
      terragrunt.hcl # Configuración de Terragrunt para el entorno dev
    /prod
      terragrunt.hcl # Configuración de Terragrunt para el entorno prod
```

### 2. Módulo `cloudwatch_log_group` (mismo que en Terraform)

Este módulo ya lo tienes listo en los archivos `main.tf`, `variables.tf`, y `outputs.tf`. Aquí no hay cambios necesarios, ya que Terragrunt simplemente usará el módulo de Terraform tal como lo hemos configurado.

### 3. Configuración de Terragrunt: `terragrunt.hcl`

#### `terragrunt.hcl` (entorno `dev`)

```hcl
terraform {
  source = "../../modules/cloudwatch_log_group"  # Ruta al módulo Terraform
}

inputs = {
  name              = "dev-log-group"          # Nombre del Log Group
  retention_in_days = 30                        # Retención de 30 días
  tags = {
    "Environment" = "dev"
    "Project"     = "my-project"
  }
}
```

#### `terragrunt.hcl` (entorno `prod`)

```hcl
terraform {
  source = "../../modules/cloudwatch_log_group"  # Ruta al módulo Terraform
}

inputs = {
  name              = "prod-log-group"         # Nombre del Log Group
  retention_in_days = 365                       # Retención de 365 días
  tags = {
    "Environment" = "prod"
    "Project"     = "my-project"
  }
}
```

### 4. Explicación de Terragrunt

1. **`terraform.source`**: Esta línea indica que Terragrunt debe usar el módulo de Terraform ubicado en `../../modules/cloudwatch_log_group`. La ruta es relativa a la ubicación del archivo `terragrunt.hcl`.

2. **`inputs`**: Aquí se pasan las variables al módulo de Terraform. En este caso, se pasan:
   - `name`: El nombre del Log Group (diferente entre `dev` y `prod`).
   - `retention_in_days`: El número de días de retención de los logs.
   - `tags`: Las etiquetas asociadas al Log Group. En este caso, estamos usando un mapa con `Environment` y `Project` como etiquetas.

### 5. Ejemplo de ejecución

Para aplicar esta configuración desde Terragrunt, puedes hacer lo siguiente:

#### En el entorno `dev`:

```bash
cd environments/dev
terragrunt apply
```

#### En el entorno `prod`:

```bash
cd environments/prod
terragrunt apply
```

Terragrunt tomará la configuración desde el archivo `terragrunt.hcl` y aplicará el módulo `cloudwatch_log_group` con los valores de las variables específicas para cada entorno.

### 6. Outputs

Al igual que en la configuración de Terraform, los outputs definidos en el módulo también estarán disponibles. Si necesitas imprimir los outputs, puedes agregarlos en el `terragrunt.hcl` de la siguiente manera:

```hcl
output "log_group_name" {
  value = module.cloudwatch_log_group.log_group_name
}

output "log_group_arn" {
  value = module.cloudwatch_log_group.log_group_arn
}
```

### 7. Resumen

- **Módulo Terraform**: Se mantiene tal cual, sin cambios.
- **Terragrunt**: Usamos `terragrunt.hcl` para invocar el módulo de Terraform, pasando las variables de configuración adecuadas.
- **Modularidad**: El módulo `cloudwatch_log_group` puede ser reutilizado en diferentes entornos (como `dev` y `prod`) simplemente configurando las variables adecuadas en los archivos `terragrunt.hcl`.

Con esta estructura, puedes gestionar múltiples entornos de forma eficiente, manteniendo la configuración limpia y modular.