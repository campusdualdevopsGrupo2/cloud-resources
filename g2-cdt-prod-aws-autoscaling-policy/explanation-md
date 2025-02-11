### Documentación del Módulo: `aws_appautoscaling_policy`

#### **Propósito del Módulo**

Este módulo crea una política de escalado automático en AWS utilizando el recurso `aws_appautoscaling_policy`. Permite configurar políticas de escalado para una amplia gama de servicios de AWS que soportan Auto Scaling, como ECS, DynamoDB, RDS, entre otros. La política de escalado puede ser de tipo **TargetTracking** o **StepScaling**, y ajusta automáticamente los recursos según las métricas de rendimiento que definamos.

### **Estructura del Módulo**

El módulo de **AWS App Auto Scaling Policy** se organiza en archivos Terraform con variables de entrada, recursos y outputs:

1. **Variables de Entrada**: Definen todos los parámetros necesarios para crear y personalizar la política de escalado. Se pueden utilizar bloques condicionales y dinámicos para hacer el módulo más flexible.
   
2. **Recurso `aws_appautoscaling_policy`**: Crea la política de escalado automático utilizando las configuraciones proporcionadas por las variables de entrada.

3. **Outputs**: Proporcionan información clave sobre la política de escalado creada, como su ARN, nombre y otras configuraciones relacionadas.

---

### **Variables de Entrada**

A continuación, se describen las variables principales que se deben configurar para utilizar el módulo correctamente:

1. **`name`**: El nombre de la política de escalado (string).
2. **`service_namespace`**: El espacio de nombres del servicio de escalado (por ejemplo, "ecs", "dynamodb").
3. **`resource_id`**: El ID del recurso al cual se aplicará la política de escalado (puede ser un servicio ECS, una tabla DynamoDB, etc.).
4. **`scalable_dimension`**: La dimensión escalable del recurso (por ejemplo, `ecs:service:DesiredCount`).
5. **`policy_type`**: El tipo de política de escalado. Puede ser **TargetTracking** o **StepScaling**.
6. **`target_value`**: El valor objetivo para las políticas de **TargetTracking** (por ejemplo, 50 para el 50% de CPU).
7. **`predefined_metric_type`**: El tipo de métrica predefinida para **TargetTracking** (por ejemplo, `ECSServiceAverageCPUUtilization`).
8. **`scale_in_cooldown`**: El tiempo de enfriamiento para escalado hacia abajo (en segundos).
9. **`scale_out_cooldown`**: El tiempo de enfriamiento para escalado hacia arriba (en segundos).
10. **`adjustment_type`**: El tipo de ajuste para **StepScaling** (por ejemplo, `PercentChangeInCapacity`).
11. **`scaling_adjustment`**: El valor de ajuste de escalado para **StepScaling** (por ejemplo, `10` para aumentar el 10% de la capacidad).
12. **`cooldown`**: El período de enfriamiento entre ajustes de escalado en **StepScaling**.

### **Recurso Principal: `aws_appautoscaling_policy`**

El recurso `aws_appautoscaling_policy` es el corazón de este módulo y se utiliza para crear la política de escalado. A continuación, se presenta un ejemplo de su configuración.

```hcl
resource "aws_appautoscaling_policy" "this" {
  name               = var.name
  service_namespace  = var.service_namespace
  resource_id        = var.resource_id
  scalable_dimension = var.scalable_dimension
  policy_type        = var.policy_type

  # Configuración de TargetTracking
  target_tracking_scaling_policy_configuration {
    target_value = var.target_value

    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }

    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }

  # Configuración de StepScaling
  step_scaling_policy_configuration {
    adjustment_type    = var.adjustment_type
    scaling_adjustment = var.scaling_adjustment
    cooldown           = var.cooldown
  }
}
```

### **Outputs**

Este módulo genera los siguientes outputs que permiten reutilizar la información de la política de escalado en otros módulos o configuraciones:

1. **`policy_name`**: Nombre de la política de escalado.
2. **`policy_arn`**: ARN de la política de escalado, utilizado para hacer referencia a la política en otros recursos.
3. **`policy_type`**: Tipo de política de escalado (TargetTracking o StepScaling).
4. **`scalable_dimension`**: Dimensión escalable del recurso.
5. **`target_value`**: El valor objetivo para **TargetTracking** (si se usa).
6. **`predefined_metric_type`**: Tipo de métrica predefinida para **TargetTracking** (si se usa).
7. **`scale_in_cooldown`** y **`scale_out_cooldown`**: Tiempos de enfriamiento para políticas **TargetTracking**.
8. **`adjustment_type`** y **`scaling_adjustment`**: Configuración para **StepScaling**.

---

### **Caso de Uso en Terragrunt**

Este módulo es ideal para ser utilizado en un entorno organizado con Terragrunt. A continuación, se muestra cómo podrías usar este módulo en un archivo `terragrunt.hcl`.

#### **Ejemplo de Uso de Terragrunt (Producción)**

```hcl
terraform {
  source = "../../modules/appautoscaling_policy"
}

inputs = {
  name               = "prod-auto-scaling-policy"
  service_namespace  = "ecs"
  resource_id        = "arn:aws:ecs:us-west-2:123456789012:service/prod-cluster/my-ecs-service"
  scalable_dimension = "ecs:service:DesiredCount"
  policy_type        = "TargetTracking"
  target_value       = 50
  predefined_metric_type = "ECSServiceAverageCPUUtilization"
  scale_in_cooldown  = 300
  scale_out_cooldown = 300
}

outputs = {
  policy_arn = terraform.output("policy_arn")
}
```

En este ejemplo, se crea una política de escalado automática de tipo **TargetTracking** para un servicio ECS en producción. El valor objetivo es el 50% de utilización de CPU, y se configura un enfriamiento de 5 minutos tanto para escalado hacia arriba como hacia abajo.

#### **Ejemplo de Uso de Terragrunt (Staging con StepScaling)**

```hcl
terraform {
  source = "../../modules/appautoscaling_policy"
}

inputs = {
  name               = "staging-auto-scaling-policy"
  service_namespace  = "ecs"
  resource_id        = "arn:aws:ecs:us-west-2:123456789012:service/staging-cluster/my-ecs-service"
  scalable_dimension = "ecs:service:DesiredCount"
  policy_type        = "StepScaling"
  adjustment_type    = "PercentChangeInCapacity"
  scaling_adjustment = 10
  cooldown           = 300
}
```

En este ejemplo, se usa una política **StepScaling** para el entorno de staging, con un ajuste de escalado del 10% cuando se detecta una métrica de escalado. El tiempo de enfriamiento es de 5 minutos entre ajustes.

#### **Referencia a la Política de Escalado en el Servicio ECS**

Una vez que hayas definido la política de escalado con Terragrunt, puedes referenciarla en otro módulo, como el de **ECS**:

```hcl
resource "aws_ecs_service" "service" {
  name            = "my-ecs-service"
  cluster         = var.cluster
  task_definition = var.task_definition
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  autoscaling {
    policy_arn = var.policy_arn  # Referencia a la política de escalado
  }
}
```

En este caso, el servicio ECS usa la política de escalado que se ha creado, aplicando automáticamente la configuración de escalado cuando se cumplan las condiciones de métricas.

---

### **Conclusión**

Este módulo de **AWS App Auto Scaling Policy** está diseñado para ser flexible, permitiendo la configuración tanto de políticas **TargetTracking** como **StepScaling**, con varias opciones de personalización. Usando variables dinámicas y configuraciones condicionales, el módulo puede ajustarse a diversas necesidades de escalado automático en AWS.

Con la integración con **Terragrunt**, puedes aprovechar la reutilización de código y la gestión centralizada de configuraciones, facilitando la implementación de políticas de escalado automático en diferentes entornos de manera eficiente y escalable.