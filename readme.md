# Jenkins + Ansible + Kubernetes Health Check & Automation

This project demonstrates how to integrate **Jenkins**, **Ansible**, and **Kubernetes (Minikube)** to automate:
1. Deploying two Kubernetes pods.
2. Configuring them as Ansible servers with SSH access.
3. Running a basic health check.
4. Installing and verifying **Nginx** on both pods.

---

## 🚀 Tech Stack
- **CI/CD**: Jenkins
- **Configuration Management**: Ansible
- **Container Orchestration**: Kubernetes (Minikube)
- **OS Image**: Ubuntu (with SSH + Ansible pre-installed)

---

## 📂 Project Structure
```
jenkins-ansible-k8s-healthcheck/
│── Jenkinsfile          # Jenkins pipeline definition
│── ansible-nodes.yaml   # Kubernetes manifests for 2 pods + NodePort services
│── hosts.ini            # Ansible inventory (points to Minikube IP + NodePorts)
│── healthcheck.yml      # Ansible playbook for connectivity + uptime check
│── install-nginx.yml    # Ansible playbook to install and verify Nginx
│── README.md            # Documentation
```

---

## 📄 File Explanations

### 1. **Jenkinsfile**
Defines the pipeline stages:
- **Deploy Pods** → Applies Kubernetes manifests (`ansible-nodes.yaml`).
- **Run Ansible Health Check** → Executes `healthcheck.yml`.
- **Install Nginx via Ansible** → Executes `install-nginx.yml`.

---

### 2. **ansible-nodes.yaml**
Kubernetes manifest that:
- Creates **two pods** (`ansible-node1`, `ansible-node2`) running Ubuntu.
- Installs SSH + Ansible inside each pod.
- Exposes SSH via **NodePort services** (30222, 30223).

---

### 3. **hosts.ini**
Ansible inventory file:
- Lists both pods as servers.
- Uses Minikube IP (`minikube ip`) + NodePorts for SSH connectivity.
- Example:
  ```ini
  [servers]
  192.168.49.2 ansible_port=30222 ansible_user=ansibleuser ansible_password=ansibleuser
  192.168.49.2 ansible_port=30223 ansible_user=ansibleuser ansible_password=ansibleuser


### 4. **healthcheck.yml**
Ansible playbook that:
- Runs a **ping test** to verify connectivity.
- Executes `uptime` command to check system health.
- Displays results in Jenkins console.

---

### 5. **install-nginx.yml**
Ansible playbook that:
- Updates apt cache.
- Installs **Nginx** on both pods.
- Ensures Nginx service is started and enabled.
- Displays Nginx status output.

---

## ▶️ Usage

1. Start Minikube:
   ```bash
   minikube start
   ```

2. Apply Kubernetes manifests:
   ```bash
   kubectl apply -f ansible-nodes.yaml
   ```

3. Get Minikube IP:
   ```bash
   minikube ip
   ```
   Update `hosts.ini` with this IP.

4. Run Jenkins pipeline:
   - Stage 1 → Deploys pods.
   - Stage 2 → Runs health check (`healthcheck.yml`).
   - Stage 3 → Installs Nginx (`install-nginx.yml`).

---

## ✅ Output
- Pods created: `ansible-node1`, `ansible-node2`
- Services exposed on NodePorts (30222, 30223)
- Health check results:
  - Ping success
  - Uptime displayed
- Nginx installed and running on both pods

---

## 📊 Architecture Diagram (ASCII)

```
        ┌───────────┐
        │  Jenkins  │
        └─────┬─────┘
              │
              ▼
        ┌───────────┐
        │  Ansible  │
        └─────┬─────┘
              │
   ┌──────────┴──────────┐
   │                     │
┌───────┐           ┌───────┐
│ Pod 1 │           │ Pod 2 │
│Ubuntu │           │Ubuntu │
│+ SSH  │           │+ SSH  │
│+ Ansible │        │+ Ansible │
└───────┘           └───────┘
   │                     │
   ▼                     ▼
 Nginx Installed     Nginx Installed
```

---

## 🎯 Why This Project Matters
- Demonstrates **CI/CD + IaC + Configuration Management** in one pipeline.
- Shows **end-to-end automation**: provisioning → health check → software install.
- Perfect for showcasing **DevOps + Cloud Solution Architect skills** on GitHub.

```

---
