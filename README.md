# IBM Instana’s RobotShop Microservices on AWS EKS

> End-to-end DevOps pipeline to deploy RobotShop microservices with full automation using Terraform, Jenkins, Argo CD, Helm, and AWS ALB Ingress Controller on EKS.

---
## 🔧 Project Summary

This project demonstrates how to deploy the open-source [RobotShop microservices app](https://github.com/instana/robot-shop) on AWS EKS with CI/CD and GitOps practices.

###  Key Accomplishments

- **Provisioned AWS Infrastructure**  
  Used custom reusable **Terraform modules** to create VPC, EKS cluster, and networking.

- **Deployed ALB Ingress Controller**  
  Configured the **AWS ALB Ingress Controller** to expose services via Application Load Balancer with path-based routing.

- **Remote State Configuration**  
  Configured **S3 backend** and **DynamoDB locking** for consistent Terraform operations and safe collaboration.

- **Persistent Storage Fix**  
  Resolved data loss issues for **MySQL and MongoDB** by provisioning **gp2-backed PersistentVolumes** with AWS durability (99.8–99.9%).

- **CI/CD Automation**  
  Built a full **CI/CD pipeline** for the `shipping` microservice:
  - **Jenkins** for continuous integration
  - Custom Docker agent image
  - Helm values update
  - Git commit and push to trigger CD

- **GitOps via Argo CD**  
  Migrated from traditional Jenkins Helm deployment to **Argo CD GitOps model**:
  - Auto-sync enabled
  - Version control
  - Self-healing deployments
  - Visibility and rollback support
---
## Tech Stack

| Layer              | Tool / Service                     |
|--------------------|------------------------------------|
| IaC                | Terraform                          |
| Cloud              | AWS (EKS, EC2, S3, DynamoDB)       |
| Ingress            | AWS ALB Ingress Controller         |
| CI/CD              | Jenkins, Argo CD                   |
| Containerization   | Docker                             |
| Orchestration      | Kubernetes (EKS)                   |
| GitOps             | Argo CD                            |
| Storage            | AWS gp2 PersistentVolumes          |

---

