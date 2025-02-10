# Cloud-Resources Borrador

Este repositorio gestiona la infraestructura de varios módulos utilizando herramientas como Terraform, Ansible y Kubernetes para la automatización y despliegue de recursos en AWS.

## 📂 Estructura del Repositorio

- `.github/workflows/` → Contiene los workflows de GitHub Actions para CI/CD.
- `g2-cdt-iam-roles-and-policy/` → Configuración de roles y políticas IAM.
- `g2-cdt-m2-c8-terragrunt-terragrunt-wordpress/` → Configuración de WordPress con Terragrunt.
- `g2-cdt-m3-c2-kubernetes-kubernetes/` → Configuración de clústeres de Kubernetes.
- `g2-cdt-m3-c3-eks-modulo-wordpress-eks/modulo_eks/` → Implementación de EKS con WordPress.
- `g2-cdt-m3-c4-ecr-y-eks-modulo-ecr-y-eks/` → Configuración de ECR y EKS combinados.
- `g2-cdt-m3-c5-ecs-aws-ecs/ecs_resources/` → Configuración de Amazon ECS.
- `g2-cdt-m3-c6-ecs-conf-ecs/ecs_resources/` → Configuración adicional para ECS.
- `g2-cdt-m3-c8-project-chat-app/chat_app/` → Aplicación de chat en tiempo real.
- `g2-cdt-m4-c1-app-node/app_node/` → Aplicación Node.js.
- `g2-cdt-m4-c3-bucket-s3-con-politica-de-retencion/` → Configuración de un bucket S3 con política de retención.
- `g2-cdt-null-resource/` → Configuración de Null Resources en Terraform.
- `g2-cdt-prod-aws-lb/` → Configuración de Load Balancers en AWS.
- `g2-cdt-prod-aws-lb-listener/` → Configuración de Listeners para Load Balancers.
- `g2-cdt-prod-aws-lb-target-group/` → Configuración de Target Groups en AWS.
- `g2-cdt-prod-ecr/` → Configuración de repositorios ECR.
- `g2-cdt-prod-ecs/` → Configuración de ECS en producción.
- `g2-cdt-prod-eks/` → Configuración de EKS en producción.
- `g2-cdt-prod-fixed-resources/` → Recursos fijos en producción.
- `g2-cdt-prod-iam-OICD/` → Configuración de IAM con OIDC.
- `g2-cdt-prod-kubernetes-manifest/` → Manifiestos de Kubernetes.
- `g2-cdt-prod-local-file/` → Configuración de archivos locales con Terraform.
- `g2-cdt-prod-rds/` → Configuración de bases de datos RDS.
- `g2-cdt-prod-sg/` → Configuración de Security Groups en AWS.
- `g2_cdt_prod_ec2/` → Configuración de instancias EC2.

## 🚀 Últimos Cambios

- Se actualizaron varios módulos de AWS (ECR, ECS, EKS, RDS, Security Groups, IAM, Load Balancers).
- Se mejoró la estructura de carpetas para mayor claridad y organización.
- Se añadieron políticas IAM y configuración de OIDC.
- Se agregaron nuevas configuraciones de Load Balancers y listeners.

## ⚙️ Requisitos

- [Terraform](https://www.terraform.io/downloads)
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [AWS CLI](https://aws.amazon.com/cli/)
- [Git](https://git-scm.com/downloads)

## 📖 Uso

1. Clona el repositorio:
   ```bash
   git clone https://github.com/campusdualdevopsGrupo2/infra-resources.git
   ```
2. Accede al módulo que deseas usar:
   ```bash
   cd g2-cdt-prod-aws-lb
   ```
3. Aplica la configuración con Terraform o Terragrunt:
   ```bash
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



