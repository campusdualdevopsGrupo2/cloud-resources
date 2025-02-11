### Explicación detallada

En Terraform y **Terragrunt**, un **módulo** es una unidad reutilizable que agrupa recursos relacionados, y puedes personalizar el comportamiento del módulo pasando valores a sus **entradas** (es decir, las **variables** del módulo). Cuando no usas **valores por defecto**, debes proporcionar todos los valores necesarios en el archivo `terragrunt.hcl` para asegurar que los módulos funcionen correctamente.

En el caso de **este módulo IAM**, hemos diseñado variables para que puedas personalizar la política de asunción del rol, la política de IAM y los ARNs de las políticas adjuntas sin necesidad de usar valores predeterminados. Esto te permite una flexibilidad total para configurar estos recursos de acuerdo con las necesidades de tu infraestructura.

### Pasos para usar el módulo sin valores predeterminados:

1. **Variables en el módulo**: El módulo tiene variables definidas para las políticas de asunción del rol (`assume_role_policy`), la política de IAM (`policy`) y los ARNs de las políticas (`policy_arns`). Ninguna de estas tiene un valor por defecto, por lo que **debes proporcionar esos valores en Terragrunt**.

2. **Referenciar el módulo en Terragrunt**: En Terragrunt, usas el archivo `terragrunt.hcl` para definir las entradas que se pasará a los módulos de Terraform.

3. **Ejemplo sin valores predeterminados**: Proporcionamos explícitamente todas las variables necesarias en el archivo `terragrunt.hcl` para que el módulo funcione con configuraciones específicas.

### **Archivos de Ejemplo:**

### 1. **Definición del módulo (terraform/iam_role)**

Este es el módulo `iam_role` que acabamos de crear. A continuación te recordamos cómo luce el módulo:

```hcl
# modules/iam_role/main.tf

resource "aws_iam_role" "this" {
  name = "${var.tag_value}ecs-task-execution-role"
  
  assume_role_policy = jsonencode(var.assume_role_policy)
}

resource "aws_iam_policy" "this" {
  name   = "${var.tag_value}ecs-task-execution-policy"
  policy = jsonencode(var.policy)
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(var.policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}
```

**Variables definidas en `variables.tf`:**

```hcl
variable "tag_value" {
  description = "Prefijo de nombre para las políticas y roles"
  type        = string
}

variable "assume_role_policy" {
  description = "Política de asunción de rol para el IAM Role"
  type        = any
}

variable "policy" {
  description = "Política de IAM para el role"
  type        = any
}

variable "policy_arns" {
  description = "Lista de ARN de políticas para adjuntar al role"
  type        = list(string)
}
```

### 2. **Definición de Terragrunt**

El siguiente es un ejemplo de cómo se usaría el módulo desde **Terragrunt** en un entorno específico (por ejemplo, para un entorno de desarrollo **`dev`**).

#### **`terragrunt/dev/terragrunt.hcl`**:

```hcl
terraform {
  source = "../../modules/iam_role"  # Ruta al módulo Terraform
}

inputs = {
  tag_value = "dev-"  # Prefijo para el nombre de los recursos

  # Política de asunción de rol personalizada
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  }

  # Política de IAM personalizada
  policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ecr:GetAuthorizationToken", "ecr:BatchCheckLayerAvailability"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  }

  # Políticas adicionales a adjuntar
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ]
}
```

### **Explicación del archivo `terragrunt.hcl`**:

- **`terraform.source`**: Aquí defines la ruta al módulo Terraform que deseas usar. En este caso, se encuentra en `../../modules/iam_role` (ajusta según tu estructura de carpetas).
  
- **`inputs`**: Dentro de esta sección, pasas las entradas que necesita el módulo. Estas son las variables definidas en `variables.tf` en el módulo:

  - **`tag_value`**: Prefijo para el nombre del rol y las políticas IAM.
  - **`assume_role_policy`**: Esta es una política personalizada de asunción de rol que le dice a AWS qué servicio puede asumir el rol (en este caso, ECS).
  - **`policy`**: Política de permisos de IAM personalizada para el rol. Aquí estamos permitiendo acceso a los repositorios de ECR y a los logs de CloudWatch.
  - **`policy_arns`**: Lista de ARNs de políticas adicionales que deseas adjuntar al rol, como políticas estándar de AWS (`AmazonEC2ContainerRegistryReadOnly` y `CloudWatchLogsFullAccess`).

### 3. **Ejemplo de ejecución en Terragrunt**

Una vez que tengas configurado el archivo `terragrunt.hcl` en el entorno de desarrollo, puedes ejecutar Terragrunt de la siguiente manera:

```bash
# Desde la carpeta donde está tu archivo terragrunt.hcl (en este caso, terragrunt/dev)
terragrunt apply
```

**Terragrunt** leerá el archivo `terragrunt.hcl`, ejecutará el módulo Terraform correspondiente y creará los recursos según la configuración proporcionada.

### 4. **Acceder a los Outputs en Terragrunt**

Una vez que los recursos se hayan creado, puedes usar los outputs definidos en el archivo `outputs.tf` para acceder a la información de los recursos creados, como el nombre y ARN del rol IAM o el ARN de las políticas adjuntas.

#### **Ejemplo de cómo usar los outputs en otro archivo Terragrunt (por ejemplo, en un entorno de producción `prod`)**:

#### **`terragrunt/prod/terragrunt.hcl`**:

```hcl
terraform {
  source = "../../modules/iam_role"  # Ruta al módulo Terraform
}

inputs = {
  tag_value = "prod-"  # Prefijo para los recursos de producción

  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  }

  policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ecr:GetAuthorizationToken", "ecr:BatchCheckLayerAvailability"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  }

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ]
}

output "iam_role_name" {
  value = module.iam_role.iam_role_name
}

output "iam_policy_arn" {
  value = module.iam_role.iam_policy_arn
}

output "attached_policy_arns" {
  value = module.iam_role.attached_policy_arns
}
```

**Explicación**:
- El archivo `terragrunt.hcl` de producción es similar al de desarrollo, pero los valores de entrada se adaptan para el entorno de producción. Las políticas pueden diferir, y los prefijos pueden ser distintos.
- Las salidas se refieren a los **outputs** del módulo `iam_role`, que se configuran en `outputs.tf` dentro del módulo de Terraform.

#### **Ejemplo de cómo ejecutar con outputs**:

```bash
# Para ver los outputs después de la ejecución
terragrunt output
```

Este comando te dará los valores de los outputs definidos en el módulo, como el nombre del rol y los ARNs de las políticas.

### **Conclusión**

Este enfoque **sin valores predeterminados** hace que tu infraestructura sea completamente configurable a través de **Terragrunt**, lo que permite un nivel de personalización en cada entorno, como **desarrollo**, **producción**, etc. Este patrón es útil cuando se trabaja con diferentes configuraciones para cada entorno o proyecto, y puedes asegurarte de que todos los parámetros sean explícitos y manejables.

- Usar Terragrunt te permite gestionar múltiples entornos sin duplicar la configuración.
- El módulo sigue siendo reutilizable, pero ahora con la flexibilidad de aceptar configuraciones específicas para cada entorno.

Si tienes más dudas o necesitas más ejemplos, ¡no dudes en preguntar!