# Jenkins + Ansible + Kubernetes Health Check

This project demonstrates a Jenkins pipeline that:
1. Deploys **two Kubernetes pods** on Minikube.
2. Configures them as **Ansible servers** with SSH access.
3. Runs a basic **health check** using Ansible (`ping` + `uptime`).

---

## 🚀 Tech Stack
- Jenkins
- Ansible
- Kubernetes (Minikube)
- Docker (Ubuntu base image)

---

## 📂 Files
- **Jenkinsfile** → Pipeline stages (deploy pods, run Ansible playbook).
- **ansible-nodes.yaml** → Kubernetes manifests for 2 pods + NodePort services.
- **hosts.ini** → Ansible inventory pointing to Minikube IP + NodePorts.
- **healthcheck.yml** → Ansible playbook to run ping + uptime checks.

---

## ▶️ Usage
1. Start Minikube:
   ```bash
   minikube start
