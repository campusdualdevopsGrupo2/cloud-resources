### **Explicación Detallada del Módulo `aws_lb_listener` Genérico**

---

#### **Propósito del Módulo**

Este módulo está diseñado para crear un **listener** en un **Load Balancer** de AWS, utilizando el recurso `aws_lb_listener` de Terraform. Los listeners son componentes que gestionan el tráfico entrante en el Load Balancer, en función de las reglas definidas (por ejemplo, redirigir, responder con contenido fijo, o enviar tráfico a un grupo de destino). El módulo es **genérico** y permite definir configuraciones flexibles para manejar diferentes tipos de listeners y acciones de manera escalable.

---

#### **Características del Módulo Genérico**

1. **Configuración de Protocolo Flexible**:
   - El módulo permite definir listeners para `HTTP` y `HTTPS`. Si el protocolo es `HTTPS`, se incluyen configuraciones para **SSL** como `ssl_policy` y `certificate_arn`.
   
2. **Acciones Predeterminadas Flexibles**:
   - Puedes definir múltiples tipos de acción para un listener, como:
     - **`forward`**: Redirige el tráfico a un grupo de destino.
     - **`fixed-response`**: Responde con un mensaje fijo.
     - **`redirect`**: Redirige la solicitud a otro host, puerto, o ruta.
   - Las acciones se configuran de forma dinámica, por lo que puedes añadir tantos tipos como sea necesario.

3. **Configuración SSL Condicional**:
   - Las configuraciones relacionadas con SSL (`ssl_policy` y `certificate_arn`) solo se aplican si el protocolo del listener es `HTTPS`.

4. **Configuración Dinámica**:
   - El módulo utiliza **bloques dinámicos** para manejar de forma flexible y escalable las acciones y condiciones. Los bloques dinámicos permiten agregar o eliminar configuraciones sin modificar el código del módulo.

---

#### **Estructura del Módulo**

##### **Código del Recurso: `aws_lb_listener`**

```hcl
resource "aws_lb_listener" "this" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol

  # Configuración SSL opcional solo si el protocolo es HTTPS
  dynamic "ssl_configuration" {
    for_each = var.protocol == "HTTPS" ? [1] : []
    content {
      ssl_policy      = var.ssl_policy
      certificate_arn = var.certificate_arn
    }
  }

  # Acciones predeterminadas dinámicas
  dynamic "default_action" {
    for_each = var.default_actions
    content {
      type             = default_action.value.type
      target_group_arn = default_action.value.target_group_arn

      # Bloques dinámicos para tipos de acción específicos
      dynamic "fixed_response" {
        for_each = default_action.value.type == "fixed-response" ? [1] : []
        content {
          status_code  = default_action.value.fixed_response.status_code
          content_type = default_action.value.fixed_response.content_type
          message_body = default_action.value.fixed_response.message_body
        }
      }

      dynamic "redirect" {
        for_each = default_action.value.type == "redirect" ? [1] : []
        content {
          status_code = default_action.value.redirect.status_code
          host        = default_action.value.redirect.host
          path        = default_action.value.redirect.path
          query       = default_action.value.redirect.query
          port        = default_action.value.redirect.port
          protocol    = default_action.value.redirect.protocol
        }
      }
    }
  }
}
```

---

### **Variables de Entrada (Input Variables)**

#### **`variables.tf`**

```hcl
variable "load_balancer_arn" {
  description = "ARN del Load Balancer al que se asocia el listener"
  type        = string
}

variable "port" {
  description = "El puerto en el que escucha el Load Balancer"
  type        = number
}

variable "protocol" {
  description = "El protocolo para el listener (HTTP, HTTPS)"
  type        = string
}

variable "ssl_policy" {
  description = "La política SSL para HTTPS"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "ARN del certificado SSL para HTTPS"
  type        = string
  default     = ""
}

# Acciones predeterminadas: Lista de acciones
variable "default_actions" {
  description = "Lista de acciones predeterminadas para el listener"
  type = list(object({
    type             = string
    target_group_arn = string
    fixed_response = optional(object({
      status_code = string
      content_type = string
      message_body = string
    }))
    redirect = optional(object({
      status_code = string
      host        = string
      path        = string
      query       = string
      port        = string
      protocol    = string
    }))
  }))
  default = []
}
```

---

#### **Descripción de las Variables**:

1. **`load_balancer_arn`**: El ARN del Load Balancer donde se creará el listener.
2. **`port`**: El puerto en el que el listener escuchará las solicitudes.
3. **`protocol`**: El protocolo que utilizará el listener (puede ser `HTTP` o `HTTPS`).
4. **`ssl_policy`**: Configuración de la política SSL, solo relevante si el protocolo es `HTTPS`.
5. **`certificate_arn`**: ARN del certificado SSL, solo necesario si el protocolo es `HTTPS`.
6. **`default_actions`**: Lista de acciones predeterminadas que el listener debe ejecutar. Puede incluir múltiples tipos de acción como `forward`, `fixed-response`, o `redirect`.

---

### **Ejemplo de Uso con Terragrunt**

#### **`terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/lb_listener"  # Ruta al módulo de Terraform
}

inputs = {
  load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188"
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abcd-efgh-ijkl-mnop"

  default_actions = [
    {
      type             = "forward"
      target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/my-target-group/73e2b9e7d5f2c4b9"
    },
    {
      type = "fixed-response"
      fixed_response = {
        status_code  = "200"
        content_type = "text/plain"
        message_body = "Service is up!"
      }
    },
    {
      type = "redirect"
      redirect = {
        status_code = "301"
        host        = "www.example.com"
        path        = "/new-path"
        query       = "key=value"
        port        = "443"
        protocol    = "HTTPS"
      }
    }
  ]
}
```

### **Explicación del Ejemplo**:

1. **`load_balancer_arn`**: El ARN de tu Load Balancer en AWS. Este ARN identifica a qué Load Balancer asociarás el listener.
2. **`port`**: El listener está configurado para escuchar en el puerto `443`, que es el puerto estándar para HTTPS.
3. **`protocol`**: Se especifica el protocolo `HTTPS`, lo que activa la configuración SSL (usando `ssl_policy` y `certificate_arn`).
4. **`ssl_policy` y `certificate_arn`**: Estas variables definen la política de seguridad SSL y el ARN del certificado SSL que se usará para el listener HTTPS.
5. **`default_actions`**: Se definen tres acciones para este listener:
   - **`forward`**: Redirige el tráfico a un grupo de destino específico.
   - **`fixed-response`**: Responde con un mensaje simple "Service is up!" cuando se cumple la condición.
   - **`redirect`**: Redirige las solicitudes a `www.example.com` en una nueva ruta (`/new-path`), con parámetros de consulta adicionales.

---

### **Comandos para Ejecutar con Terragrunt**

1. **Ejecutar el plan de Terraform** con Terragrunt:

```bash
terragrunt plan
```

Este comando mostrará las diferencias entre tu configuración actual y lo que se aplicaría, permitiéndote revisar los cambios antes de aplicarlos.

2. **Aplicar los cambios**:

```bash
terragrunt apply
```

Este comando aplica la configuración y crea el listener en AWS según lo definido en el archivo `terragrunt.hcl` y el módulo de Terraform.

---

### **Conclusión**

Este módulo **genérico** para la creación de **listeners** en AWS Load Balancers te permite gestionar de forma flexible los listeners de `HTTP` y `HTTPS`. Utilizando bloques dinámicos y variables configurables, el módulo puede manejar una amplia variedad de casos de uso, como acciones de redirección, respuestas fijas o la asignación de tráfico a grupos de destino. Con la integración de **Terragrunt**, puedes mantener tu infraestructura organizada y reutilizable, aplicando configuraciones consistentes y fáciles de gestionar en diferentes entornos.