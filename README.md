# cloud-resources



Este repositorio contiene los recursos de infraestructura para la gestión y despliegue de diversas aplicaciones y servicios en la nube.

## 📂 Estructura del Repositorio

- `.github/workflows/` → Contiene los workflows de GitHub Actions para la automatización del CI/CD.
- `g2-cdt-m2-c4-ansible-wordpress/` → Configuración de Ansible para desplegar WordPress en EC2.
- `g2-cdt-m2-c8-terragrunt-terragrunt-wordpress/` → Configuración de Terragrunt para el despliegue de WordPress.
- `g2-cdt-m3-c2-kubernetes-kubernetes/` → Configuración de Kubernetes.
- `g2-cdt-m3-c3-eks-modulo-wordpress-eks/modulo_eks/` → Configuración de EKS con WordPress.
- `g2-cdt-m3-c4-ecr-y-eks-modulo-ecr-y-eks/` → Configuración combinada de ECR y EKS.
- `g2-cdt-m3-c5-ecs-aws-ecs/ecs_resources/` → Configuración de Amazon ECS.
- `g2-cdt-m3-c6-ecs-conf-ecs/ecs_resources/` → Configuración adicional para ECS.
- `g2-cdt-m3-c8-project-chat-app/chat_app/` → Aplicación de chat en tiempo real.
- `g2-cdt-m4-c1-app-node/app_node/` → Aplicación Node.js.
- `g2-cdt-m4-c3-bucket-s3-con-politica-de-retencion/bucket-s3-con-politica-de-retencion/` → Configuración de un bucket S3 con una política de retención.
- `g2-cdt-prod-fixed-resources/` → Recursos fijos de producción.
- `.gitignore` → Archivo de configuración para ignorar archivos innecesarios en Git.
- `README.md` → Documentación del repositorio.

## 🚀 Descripción General

Este repositorio forma parte del trabajo del equipo **campusdualdevopsGrupo2**, donde se desarrollan módulos de infraestructura utilizando herramientas como Terraform, Terragrunt, Ansible, Kubernetes, AWS y GitHub Actions.

## 📌 Últimos Cambios

- Se realizaron actualizaciones en los workflows de GitHub Actions.
- Se modificaron los nombres y estructuras de carpetas de varios módulos para mayor claridad.
- Se agregaron políticas de retención a un bucket S3 en `g2-cdt-m4-c3-bucket-s3-con-politica-de-retencion`.
- Se agregó un `.gitignore` para optimizar el repositorio.

## ⚙️ Requisitos

Para utilizar este repositorio, asegúrate de tener instalados:

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
2. Accede al directorio del módulo que deseas utilizar:
   ```bash
   cd g2-cdt-m3-c3-eks-modulo-wordpress-eks
   ```
3. Aplica la configuración con Terraform o Terragrunt:
   ```bash
   terragrunt run-all apply
   ```

## 🛠 Contribución

Si deseas contribuir a este proyecto, sigue estos pasos:

1. Crea un fork del repositorio.
2. Crea una nueva rama con un nombre descriptivo.
3. Realiza tus cambios y realiza un commit.
4. Abre un Pull Request para revisión.

## 📜 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.

---

✉️ Para dudas o sugerencias, contacta con los administradores del repositorio o abre un issue.



