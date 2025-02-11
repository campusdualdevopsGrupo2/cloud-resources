### **Documento: Modulo Genérico para Reglas de Listener en AWS Application Load Balancer (ALB)**

---

#### **Introducción**

Este módulo de Terraform está diseñado para gestionar las **reglas de listeners** en un **AWS Application Load Balancer (ALB)** o **Elastic Load Balancer (ELB)**. Con este módulo, puedes crear reglas con condiciones y acciones altamente personalizables, utilizando **bloques dinámicos** para manejar múltiples condiciones y acciones.

El propósito de este módulo es hacerlo lo más flexible posible, permitiendo que los usuarios definan diferentes tipos de condiciones (como `host_header`, `path_pattern`, y `query_string`) y diversas acciones (como `forward`, `fixed-response`, o `redirect`), todo a través de variables de entrada fáciles de manejar.

---

#### **Características Principales del Módulo**

1. **Acciones Dinámicas**: 
   - Puedes definir múltiples tipos de acción como `forward`, `fixed-response`, `redirect`, etc.
   - Las acciones se configuran a través de un bloque dinámico para permitir la mayor flexibilidad posible.

2. **Condiciones Dinámicas**: 
   - El módulo soporta varias condiciones, incluyendo `host_header`, `path_pattern`, y `query_string`, lo que permite configurar reglas más avanzadas de manera fácil y escalable.

3. **Variables Flexibles**:
   - El módulo está diseñado con variables que permiten introducir condiciones y acciones en un formato flexible, sin que sea necesario modificar el código del módulo.

---

### **Estructura del Módulo**

#### **Recurso: aws_lb_listener_rule**

```hcl
resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn
  priority     = var.priority

  dynamic "action" {
    for_each = var.actions
    content {
      type             = action.value.type
      target_group_arn = action.value.target_group_arn
      # Otras acciones personalizadas pueden agregarse aquí según el tipo
    }
  }

  dynamic "condition" {
    for_each = var.conditions
    content {
      dynamic "host_header" {
        for_each = contains(keys(condition.value), "host_header") ? [1] : []
        content {
          values = condition.value.host_header
        }
      }

      dynamic "path_pattern" {
        for_each = contains(keys(condition.value), "path_pattern") ? [1] : []
        content {
          values = condition.value.path_pattern
        }
      }

      dynamic "query_string" {
        for_each = contains(keys(condition.value), "query_string") ? [1] : []
        content {
          values = condition.value.query_string
        }
      }
    }
  }
}
```

#### **Explicación del Código**:
1. **Acciones Dinámicas (`action`)**:
   - El bloque de acción se define dinámicamente usando la lista de `var.actions`, lo que permite que el usuario defina múltiples tipos de acción, como `forward`, `fixed-response`, etc.
   - Dentro del bloque de acción, puedes personalizar cada tipo de acción con atributos específicos, como el `target_group_arn` para las acciones de tipo `forward`.

2. **Condiciones Dinámicas (`condition`)**:
   - El bloque de condiciones también es dinámico, permitiendo diferentes tipos de condiciones.
   - Dependiendo de las claves presentes en la condición (`host_header`, `path_pattern`, `query_string`), el módulo genera el bloque correspondiente de forma automática.

---

### **Variables de Entrada**

Para que el módulo sea flexible y genérico, se definen las siguientes variables de entrada:

#### **`variables.tf`**

```hcl
variable "listener_arn" {
  description = "ARN del listener del Load Balancer"
  type        = string
}

variable "priority" {
  description = "Prioridad de la regla del listener"
  type        = number
}

# Acciones dinámicas: Lista de acciones
variable "actions" {
  description = "Lista de acciones a realizar en la regla del listener"
  type = list(object({
    type             = string
    target_group_arn = string
    # Puedes añadir más campos si se agregan más tipos de acciones
    # fixed_response = optional(object({
    #   status_code = string
    #   content_type = string
    #   message_body = string
    # }))
  }))
  default = []
}

# Condiciones dinámicas: Lista de condiciones
variable "conditions" {
  description = "Lista de condiciones para la regla del listener"
  type = list(object({
    host_header    = optional(list(string))
    path_pattern   = optional(list(string))
    query_string   = optional(list(object({
      key   = string
      value = string
    })))
  }))
  default = []
}
```

#### **Descripción de las Variables**:
1. **`listener_arn`**: El ARN del listener del Load Balancer donde se aplicará la regla.
2. **`priority`**: Prioridad de la regla (número entero).
3. **`actions`**: Lista de acciones que se pueden aplicar a la regla. Cada acción tiene los campos `type` y `target_group_arn`. Si deseas agregar más tipos de acción, simplemente extiende este objeto con nuevos atributos.
4. **`conditions`**: Lista de condiciones que se aplican a la regla. Las condiciones pueden incluir:
   - `host_header`: Encabezado `Host` para la condición.
   - `path_pattern`: Condiciones basadas en la ruta.
   - `query_string`: Condiciones basadas en parámetros de la consulta.

---

### **Ejemplo de Uso con Terragrunt**

#### **`terragrunt.hcl`**

```hcl
terraform {
  source = "../../modules/lb_listener_rule"  # Ruta al módulo de Terraform
}

inputs = {
  listener_arn = "arn:aws:elasticloadbalancing:region:account-id:listener/app/my-load-balancer/50dc6c495c0c9188"
  priority     = 10

  actions = [
    {
      type             = "forward"
      target_group_arn = "arn:aws:elasticloadbalancing:region:account-id:targetgroup/my-target-group/73e2b9e7d5f2c4b9"
    },
    {
      type             = "fixed-response"
      fixed_response = {
        status_code = "200"
        content_type = "text/plain"
        message_body = "Hello, World!"
      }
    }
  ]

  conditions = [
    {
      host_header  = ["example.com"]
      path_pattern = ["/images/*"]
    },
    {
      query_string = [
        {
          key   = "user"
          value = "admin"
        }
      ]
    }
  ]
}
```

#### **Explicación**:
1. **`listener_arn`**: Debes proporcionar el ARN del listener de tu Load Balancer en AWS.
2. **`priority`**: Define la prioridad de la regla. Cuanto menor sea el valor, mayor prioridad tiene la regla.
3. **`actions`**: Define las acciones que se deben tomar cuando se cumpla la regla. En este caso, hay dos acciones:
   - **`forward`**: Redirige el tráfico a un grupo de destino especificado por `target_group_arn`.
   - **`fixed-response`**: Responde con un mensaje fijo (en este caso, un mensaje `Hello, World!`).
4. **`conditions`**: Establece las condiciones que deben cumplirse para que se aplique la regla. En este ejemplo:
   - La regla se aplica solo si el encabezado `Host` es `example.com` y la ruta coincide con el patrón `/images/*`.
   - También se aplica si la cadena de consulta contiene un parámetro `user=admin`.

---

### **Comandos para Ejecutar con Terragrunt**

Una vez que hayas configurado tu archivo `terragrunt.hcl` con las variables adecuadas, puedes ejecutar el siguiente comando para aplicar la configuración:

```bash
terragrunt apply
```

Este comando utilizará los valores especificados en tu archivo `terragrunt.hcl` y aplicará la configuración para crear las reglas del listener con las condiciones y acciones definidas.

---

### **Conclusión**

Este módulo genérico para las reglas de **AWS Load Balancer** te permite gestionar reglas complejas con condiciones y acciones flexibles. Utilizando **bloques dinámicos** y **variables genéricas**, este módulo es fácil de adaptar a una variedad de casos de uso sin tener que modificar el código. Con la configuración proporcionada por Terragrunt, puedes aplicar estas reglas de manera eficiente a tus recursos en AWS.