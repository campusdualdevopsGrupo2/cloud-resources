# Cloud-Resources Borrador

Este repositorio contiene módulos para la administración y despliegue de infraestructura en AWS utilizando Terraform.

## 📂 Estructura del Repositorio

### 🔥 Autoescalado y Balanceo de Carga
- `g2-cdt-prod-aws-autoscaling-policy/` → Configuración de políticas de autoescalado en AWS.
- `g2-cdt-prod-aws-autoscaling-target/` → Configuración de targets para autoescalado.
- `g2-cdt-prod-aws-lb/` → Configuración de Load Balancers en AWS.
- `g2-cdt-prod-aws-lb-listener/` → Configuración de listeners para Load Balancers.
- `g2-cdt-prod-aws-lb-listener-rule/` → Reglas de listener para Load Balancers.
- `g2-cdt-prod-aws-lb-target-group/` → Configuración de Target Groups para Load Balancers.

### 🛠️ Contenedores y Orquestación
- `g2-cdt-prod-ecr/` → Configuración de repositorios en Amazon Elastic Container Registry (ECR).
- `g2-cdt-prod-ecs/` → Configuración de Amazon ECS.
- `g2-cdt-prod-aws-ecs-service/` → Configuración de servicios en ECS.
- `g2-cdt-prod-aws-ecs-task-definition/` → Definiciones de tareas para ECS.
- `g2-cdt-prod-eks/` → Configuración de Amazon Elastic Kubernetes Service (EKS).
- `g2-cdt-prod-kubernetes-deployment/` → Configuración de despliegues en Kubernetes.
- `g2-cdt-prod-kubernetes-horizontal-pod-autoscaler/` → Configuración de HPA en Kubernetes.
- `g2-cdt-prod-kubernetes-manifest/` → Manifiestos de Kubernetes.
- `g2-cdt-prod-kubernetes-service/` → Configuración de servicios en Kubernetes.

### 🔑 Seguridad e IAM
- `g2-cdt-prod-iam-OICD/` → Configuración de OIDC en AWS IAM.
- `g2-cdt-prod-iam-roles-and-policy/` → Configuración de roles y políticas en AWS IAM.
- `g2-cdt-prod-sg/` → Configuración de Security Groups en AWS.
- `g2-cdt-prod-aws-secretmanager-secret/` → Configuración de AWS Secrets Manager.
- `g2-cdt-prod-aws-secretmanager-secret-version/` → Versiones de secretos en AWS Secrets Manager.

### 🗄️ Almacenamiento y Bases de Datos
- `g2_cdt_prod_s3/` → Configuración de Amazon S3.
- `g2-cdt-prod-rds/` → Configuración de bases de datos en Amazon RDS.
- `g2-cdt-prod-local-file/` → Módulo para gestionar archivos locales en Terraform.

### ⚙️ Otros Módulos
- `g2_cdt_prod_ec2/` → Configuración de instancias EC2 en AWS.
- `g2-cdt-prod-null-resource/` → Uso de Null Resources para despliegues personalizados.
- `g2-cdt-prod-fixed-resources` → Recursos fijos y configuración base en AWS.

## 🚀 Últimos Cambios
- Se han añadido módulos de autoescalado y balanceo de carga.
- Mejoras en la configuración de ECS y EKS.
- Correcciones en RDS y Kubernetes.
- Añadidos módulos de Secrets Manager y Security Groups.

## ⚙️ Requisitos
- [Terraform](https://www.terraform.io/downloads)
- [AWS CLI](https://aws.amazon.com/cli/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Git](https://git-scm.com/downloads)

## 📖 Uso
1. Clona el repositorio:
   ```bash
   git clone https://github.com/campusdualdevopsGrupo2/infra-resources.git
   ```
2. Accede al módulo que deseas usar:
   ```bash
   cd g2-cdt-prod-aws-ecs-service
   ```
3. Aplica la configuración con Terraform:
   ```bash
   terraform init
   terraform apply
   ```

## 🛠 Contribución
1. Crea un fork del repositorio.
2. Crea una nueva rama con un nombre descriptivo.
3. Realiza tus cambios y realiza un commit.
4. Abre un Pull Request para revisión.

## 📜 Licencia
Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.

---
✉️ Para dudas o sugerencias, contacta con los administradores del repositorio o abre un issue.

