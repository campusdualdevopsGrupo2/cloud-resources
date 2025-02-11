¡Entendido! Si cada submódulo es completamente independiente y está organizado en su propia carpeta con sus propias variables y salidas, entonces cada submódulo debería estar completamente desacoplado de los demás. Además, **Terragrunt** se puede usar para manejar configuraciones entre entornos y para facilitar la reutilización de los submódulos, sin necesidad de que cada uno dependa de otro dentro de la misma carpeta.

### Estructura del Proyecto con Módulos Independientes y Terragrunt

Dado que cada módulo es completamente independiente, cada submódulo tendrá su propia carpeta que contiene sus propios archivos de variables (`variables.tf`), recursos (`main.tf`), y salidas (`outputs.tf`). **Terragrunt** se usará para orquestar la configuración del entorno sin necesidad de que los submódulos estén vinculados entre sí dentro de las carpetas de Terraform.

#### Estructura de Directorios

```plaintext
terraform/
├── modules/
│   ├── s3_bucket/
│   │   ├── main.tf             # Define el recurso aws_s3_bucket
│   │   ├── variables.tf        # Variables específicas para el bucket S3
│   │   ├── outputs.tf          # Salidas del bucket S3
│   ├── s3_versioning/
│   │   ├── main.tf             # Configuración de versionado
│   │   ├── variables.tf        # Variables para el versionado
│   │   ├── outputs.tf          # Salidas del versionado
│   ├── s3_lifecycle/
│   │   ├── main.tf             # Configuración de ciclo de vida
│   │   ├── variables.tf        # Variables para ciclo de vida
│   │   ├── outputs.tf          # Salidas del ciclo de vida
│   ├── s3_website/
│   │   ├── main.tf             # Configuración de sitio web
│   │   ├── variables.tf        # Variables para sitio web
│   │   ├── outputs.tf          # Salidas del sitio web
│   ├── s3_policy/
│   │   ├── main.tf             # Configuración de políticas del bucket
│   │   ├── variables.tf        # Variables para políticas
│   │   ├── outputs.tf          # Salidas de políticas
│   ├── s3_public_access/
│   │   ├── main.tf             # Configuración de acceso público
│   │   ├── variables.tf        # Variables para acceso público
│   │   ├── outputs.tf          # Salidas del acceso público
├── terragrunt/
│   ├── dev/
│   │   ├── terragrunt.hcl      # Configuración de Terragrunt para dev
│   ├── prod/
│   │   ├── terragrunt.hcl      # Configuración de Terragrunt para prod
└── terraform.tfvars            # Variables comunes globales (si las hay)
```

### 1. **Módulo Independiente: `s3_bucket`**

Este módulo se encargará de crear el bucket S3. El archivo `main.tf` se verá así:

#### `modules/s3_bucket/main.tf`

```hcl
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = var.prevent_destroy
  }
}
```

#### `modules/s3_bucket/variables.tf`

```hcl
variable "bucket_name" {
  description = "El nombre del bucket S3"
  type        = string
}

variable "prevent_destroy" {
  description = "Evitar la destrucción accidental del bucket"
  type        = bool
  default     = false
}
```

#### `modules/s3_bucket/outputs.tf`

```hcl
output "bucket_id" {
  description = "El ID del bucket S3"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "El ARN del bucket S3"
  value       = aws_s3_bucket.this.arn
}
```

### 2. **Módulo Independiente: `s3_versioning`**

Este módulo gestionará el versionado de un bucket S3.

#### `modules/s3_versioning/main.tf`

```hcl
resource "aws_s3_bucket_versioning" "this" {
  bucket = var.bucket_id

  versioning_configuration {
    status = var.versioning_status
  }
}
```

#### `modules/s3_versioning/variables.tf`

```hcl
variable "bucket_id" {
  description = "El ID del bucket S3"
  type        = string
}

variable "versioning_status" {
  description = "Estado del versionado"
  type        = string
  default     = "Suspended"
}
```

#### `modules/s3_versioning/outputs.tf`

```hcl
output "versioning_status" {
  description = "El estado del versionado del bucket"
  value       = aws_s3_bucket_versioning.this.versioning_configuration[0].status
}
```

### 3. **Módulo Independiente: `s3_lifecycle`**

Este submódulo se encarga de gestionar las reglas de ciclo de vida del bucket S3.

#### `modules/s3_lifecycle/main.tf`

```hcl
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = var.bucket_id

  rule {
    id     = var.lifecycle_rule_id
    status = var.lifecycle_status

    expiration {
      days = var.lifecycle_expiration_days
    }
  }
}
```

#### `modules/s3_lifecycle/variables.tf`

```hcl
variable "bucket_id" {
  description = "El ID del bucket S3"
  type        = string
}

variable "lifecycle_rule_id" {
  description = "El ID de la regla de ciclo de vida"
  type        = string
}

variable "lifecycle_status" {
  description = "Estado de la regla de ciclo de vida"
  type        = string
  default     = "Enabled"
}

variable "lifecycle_expiration_days" {
  description = "Número de días para la expiración de los objetos"
  type        = number
  default     = 30
}
```

#### `modules/s3_lifecycle/outputs.tf`

```hcl
output "lifecycle_rule_id" {
  description = "El ID de la regla de ciclo de vida"
  value       = aws_s3_bucket_lifecycle_configuration.this.rule[0].id
}
```

### 4. **Módulo Independiente: `s3_website`**

Este módulo configura el sitio web estático para el bucket S3.

#### `modules/s3_website/main.tf`

```hcl
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = var.bucket_id

  index_document {
    suffix = var.website_index_suffix
  }
}
```

#### `modules/s3_website/variables.tf`

```hcl
variable "bucket_id" {
  description = "El ID del bucket S3"
  type        = string
}

variable "website_index_suffix" {
  description = "El sufijo del documento índice para el sitio web"
  type        = string
  default     = "index.html"
}
```

#### `modules/s3_website/outputs.tf`

```hcl
output "website_url" {
  description = "La URL del sitio web"
  value       = "http://${aws_s3_bucket_website_configuration.this.bucket}/"
}
```

### 5. **Módulo Independiente: `s3_policy`**

Este módulo configura la política de acceso al bucket S3.

#### `modules/s3_policy/main.tf`

```hcl
resource "aws_s3_bucket_policy" "this" {
  bucket = var.bucket_id

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${var.bucket_arn}/*"
      }
    ]
  })
}
```

#### `modules/s3_policy/variables.tf`

```hcl
variable "bucket_id" {
  description = "El ID del bucket S3"
  type        = string
}

variable "bucket_arn" {
  description = "El ARN del bucket S3"
  type        = string
}
```

#### `modules/s3_policy/outputs.tf`

```hcl
output "policy_id" {
  description = "El ID de la política aplicada al bucket"
  value       = aws_s3_bucket_policy.this.id
}
```

### 6. **Módulo Independiente: `s3_public_access`**

Este módulo configura las restricciones de acceso público para el bucket S3.

#### `modules/s3_public_access/main.tf`

```hcl
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = var.bucket_id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}
```

#### `modules/s3_public_access/variables.tf`

```hcl
variable "bucket_id" {
  description = "El ID del bucket S3"
  type        = string
}

variable "block_public_acls" {
 

 description = "Bloquear los ACLs públicos"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Bloquear políticas públicas"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignorar los ACLs públicos"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restringir los buckets públicos"
  type        = bool
  default     = true
}
```

#### `modules/s3_public_access/outputs.tf`

```hcl
output "access_block_id" {
  description = "El ID de la configuración de acceso público"
  value       = aws_s3_bucket_public_access_block.this.id
}
```

### Uso de **Terragrunt**

#### 1. **Configuración de Terragrunt para el Entorno `dev`**

```hcl
terraform {
  source = "../modules/s3_bucket"
}

inputs = {
  bucket_name     = "dev-bucket"
  prevent_destroy = true
}
```

#### 2. **Configuración de Terragrunt para el Entorno `prod`**

```hcl
terraform {
  source = "../modules/s3_bucket"
}

inputs = {
  bucket_name     = "prod-bucket"
  prevent_destroy = true
}
```

Cada submódulo se invoca por separado dentro de Terragrunt, y puedes añadir configuraciones de otros submódulos (como versioning, lifecycle, website, etc.) en archivos de configuración separados de **Terragrunt** por entorno.



¡Entendido! Te proporcionaré ejemplos concretos para la configuración de **Terragrunt** en diferentes entornos. En este caso, la estructura estará organizada para que puedas usar **Terragrunt** para orquestar la creación y configuración de los diferentes submódulos de S3 de forma independiente, a nivel de carpetas, en distintos entornos como `dev` y `prod`.

Vamos a suponer que tienes los siguientes submódulos de Terraform dentro de `modules/`:

- `modules/s3_bucket/` - Crea el bucket S3.
- `modules/s3_versioning/` - Configura el versionado de S3.
- `modules/s3_lifecycle/` - Configura las reglas de ciclo de vida de S3.
- `modules/s3_website/` - Configura el sitio web estático en S3.
- `modules/s3_policy/` - Aplica una política al bucket S3.
- `modules/s3_public_access/` - Configura las restricciones de acceso público al bucket S3.

### Estructura de Directorios

```plaintext
terraform/
├── modules/
│   ├── s3_bucket/
│   ├── s3_versioning/
│   ├── s3_lifecycle/
│   ├── s3_website/
│   ├── s3_policy/
│   └── s3_public_access/
├── terragrunt/
│   ├── dev/
│   │   ├── s3_bucket/
│   │   │   └── terragrunt.hcl
│   │   ├── s3_versioning/
│   │   │   └── terragrunt.hcl
│   │   ├── s3_lifecycle/
│   │   │   └── terragrunt.hcl
│   │   ├── s3_website/
│   │   │   └── terragrunt.hcl
│   │   ├── s3_policy/
│   │   │   └── terragrunt.hcl
│   │   └── s3_public_access/
│   │       └── terragrunt.hcl
│   ├── prod/
│   │   ├── s3_bucket/
│   │   │   └── terragrunt.hcl
│   │   ├── s3_versioning/
│   │   │   └── terragrunt.hcl
│   │   ├── s3_lifecycle/
│   │   │   └── terragrunt.hcl
│   │   ├── s3_website/
│   │   │   └── terragrunt.hcl
│   │   ├── s3_policy/
│   │   │   └── terragrunt.hcl
│   │   └── s3_public_access/
│   │       └── terragrunt.hcl
└── terraform.tfvars
```

### Ejemplo de Configuración de Terragrunt para `dev`

En este ejemplo, vamos a crear un entorno de **desarrollo (`dev`)**, donde se configuran los submódulos para un bucket S3 con todas las configuraciones mencionadas. El propósito es tener configuraciones personalizadas para cada submódulo en ese entorno.

#### 1. **`terragrunt/dev/s3_bucket/terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/s3_bucket"
}

inputs = {
  bucket_name     = "dev-bucket-example"
  prevent_destroy = true
}
```

Este archivo configura el submódulo `s3_bucket` para crear un bucket llamado `dev-bucket-example` y con la opción de evitar que se destruya accidentalmente (`prevent_destroy`).

#### 2. **`terragrunt/dev/s3_versioning/terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/s3_versioning"
}

inputs = {
  bucket_id       = "dev-bucket-example"  # El bucket ya creado en dev
  versioning_status = "Enabled"
}
```

Este archivo habilita el versionado para el bucket creado en el módulo anterior. El bucket `dev-bucket-example` es pasado como `bucket_id`.

#### 3. **`terragrunt/dev/s3_lifecycle/terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/s3_lifecycle"
}

inputs = {
  bucket_id                = "dev-bucket-example"
  lifecycle_rule_id        = "dev-lifecycle-rule"
  lifecycle_status         = "Enabled"
  lifecycle_expiration_days = 30
}
```

Este archivo configura una regla de ciclo de vida en el bucket `dev-bucket-example` que elimina los objetos después de 30 días.

#### 4. **`terragrunt/dev/s3_website/terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/s3_website"
}

inputs = {
  bucket_id            = "dev-bucket-example"
  website_index_suffix = "index.html"
}
```

Este archivo configura el bucket como un sitio web estático con el archivo `index.html` como documento de inicio.

#### 5. **`terragrunt/dev/s3_policy/terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/s3_policy"
}

inputs = {
  bucket_id = "dev-bucket-example"
  bucket_arn = "arn:aws:s3:::dev-bucket-example"
}
```

Este archivo configura una política que permite el acceso público para leer los objetos dentro del bucket `dev-bucket-example`.

#### 6. **`terragrunt/dev/s3_public_access/terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/s3_public_access"
}

inputs = {
  bucket_id             = "dev-bucket-example"
  block_public_acls     = true
  block_public_policy   = true
  ignore_public_acls    = true
  restrict_public_buckets = true
}
```

Este archivo configura las restricciones para bloquear el acceso público al bucket `dev-bucket-example`.

### Ejemplo de Configuración de Terragrunt para `prod`

Para el entorno de **producción (`prod`)**, la configuración será similar, pero con algunas diferencias en los valores de entrada para adaptarse a un entorno más seguro y robusto.

#### 1. **`terragrunt/prod/s3_bucket/terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/s3_bucket"
}

inputs = {
  bucket_name     = "prod-bucket-example"
  prevent_destroy = true
}
```

En este caso, el nombre del bucket cambia a `prod-bucket-example` y se mantiene la opción de evitar la destrucción accidental del bucket.

#### 2. **`terragrunt/prod/s3_versioning/terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/s3_versioning"
}

inputs = {
  bucket_id       = "prod-bucket-example"  # El bucket ya creado en prod
  versioning_status = "Enabled"
}
```

El versionado también se habilita, pero ahora para el bucket de producción `prod-bucket-example`.

#### 3. **`terragrunt/prod/s3_lifecycle/terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/s3_lifecycle"
}

inputs = {
  bucket_id                = "prod-bucket-example"
  lifecycle_rule_id        = "prod-lifecycle-rule"
  lifecycle_status         = "Enabled"
  lifecycle_expiration_days = 60  # En producción, es probable que los objetos se conserven más tiempo
}
```

En producción, la configuración del ciclo de vida es más estricta, con un período de retención de 60 días.

#### 4. **`terragrunt/prod/s3_website/terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/s3_website"
}

inputs = {
  bucket_id            = "prod-bucket-example"
  website_index_suffix = "index.html"
}
```

Se mantiene la configuración del sitio web estático, pero ahora para el bucket de producción.

#### 5. **`terragrunt/prod/s3_policy/terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/s3_policy"
}

inputs = {
  bucket_id = "prod-bucket-example"
  bucket_arn = "arn:aws:s3:::prod-bucket-example"
}
```

La política también permite el acceso público en producción, pero podría ajustarse según las necesidades de seguridad.

#### 6. **`terragrunt/prod/s3_public_access/terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/s3_public_access"
}

inputs = {
  bucket_id             = "prod-bucket-example"
  block_public_acls     = false  # En producción, podrías querer permitir algunos accesos públicos
  block_public_policy   = true
  ignore_public_acls    = true
  restrict_public_buckets = true
}
```

En producción, podría permitirse ciertos accesos públicos, por lo que se establece `block_public_acls = false`, pero aún se bloquean otras configuraciones públicas.

---

### Ejecutando Terragrunt

Para ejecutar las configuraciones con **Terragrunt**, debes hacerlo desde el directorio del entorno en el que deseas aplicar los cambios. Por ejemplo:

#### Para el entorno `dev`:

```sh
cd terragr

unt/dev/s3_bucket
terragrunt apply

cd ../s3_versioning
terragrunt apply

cd ../s3_lifecycle
terragrunt apply

cd ../s3_website
terragrunt apply

cd ../s3_policy
terragrunt apply

cd ../s3_public_access
terragrunt apply
```

#### Para el entorno `prod`:

```sh
cd terragrunt/prod/s3_bucket
terragrunt apply

cd ../s3_versioning
terragrunt apply

cd ../s3_lifecycle
terragrunt apply

cd ../s3_website
terragrunt apply

cd ../s3_policy
terragrunt apply

cd ../s3_public_access
terragrunt apply
```

### Conclusión

Esta configuración muestra cómo utilizar **Terragrunt** para orquestar recursos de forma modular, en donde cada submódulo es independiente y tiene su propia configuración, lo que facilita la reutilización en distintos entornos (por ejemplo, `dev` y `prod`).