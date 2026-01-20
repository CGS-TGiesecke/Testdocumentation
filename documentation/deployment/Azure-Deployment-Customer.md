## Deploying CGS Assist on a Cloud Server: General Step-by-Step Guide

This guide provides a general approach to deploying **CGS Assist** on a customer's cloud server. Adjust and customize this process as per the server setup, cloud provider, and specific requirements.

---

### Prerequisites

- **Cloud Server Setup**: Ensure you have an Ubuntu server (tested with Ubuntu 24.04 or newer).
- **Server Access**: SSH access to the cloud server.
- **Docker Installed**: Docker and Docker Compose must be installed.
- **Configuration Files**: Required configuration files (`config.yaml`, `.env`) prepared beforehand.
- **Image Registry Credentials**: Credentials to access the Docker registry (e.g., Docker Hub or Azure Container Registry) where the CGS Assist images are stored.

---

### 1. Set Up the Server Environment

#### 1.1 Update Server Packages
```bash
sudo apt update && sudo apt upgrade -y
```

#### 1.2 Install Required Dependencies
```bash
sudo apt install -y ca-certificates curl gnupg lsb-release
```

#### 1.3 Install Docker
1. Add Docker’s repository key:
   ```bash
   sudo mkdir -p /etc/apt/keyrings
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   ```
2. Add Docker’s repository:
   ```bash
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```
3. Update the package list and install Docker:
   ```bash
   sudo apt update
   sudo apt install -y docker-ce docker-ce-cli containerd.io
   ```
4. Ensure Docker is running:
   ```bash
   sudo systemctl start docker
   sudo systemctl enable docker
   sudo systemctl status docker
   ```
5. Add the current user to the `docker` group to avoid using `sudo` with Docker:
   ```bash
   sudo usermod -aG docker $USER
   newgrp docker
   ```

---

### 2. Install Docker Compose

1. Confirm Docker Compose is installed (Docker Compose Plugin):
   ```bash
   docker compose version
   ```
2. If not installed, install it:
   ```bash
   sudo apt install -y docker-compose-plugin
   ```

---

### 3. Copy Required Files

1. Set up a directory on the server for hosting the files (e.g., `/home/<user>/shared_folder`):
   ```bash
   mkdir -p ~/shared_folder
   ```
2. Transfer configuration files, Docker Compose file, and any other required assets to the server using `scp` or similar tools:
   ```bash
   scp -i <path-to-ssh-key> <local-path-to-files> <user>@<server-ip>:~/shared_folder
   ```
3. Verify the files are present on the cloud server:
   ```bash
   ls ~/shared_folder
   ```

---

### 4. Configure Docker Compose

1. Navigate to the directory:
   ```bash
   cd ~/shared_folder
   ```
2. Ensure proper configuration of the `.env` file for environment variables, like the `AZURE_OPENAI_API_KEY`, required in the setup:
   ```
   AZURE_OPENAI_API_KEY=YOUR_API_KEY_HERE
   OTHER_ENV_VAR=VALUE_HERE
   ```
3. Ensure any dependent configuration files (like `config.yaml`) are in the correct paths as referenced by the services.

---

### 5. Pull Docker Images

1. Authenticate with the Docker registry:
   ```
   docker login -u <registry-username> -p <registry-password>
   ```
2. Pull the required images using `docker-compose.yaml`:
   ```bash
   docker compose pull
   ```
3. Verify that all images are downloaded:
   ```bash
   docker images
   ```

---

### 6. Start CGS Assist Services

Start the services defined in the `docker-compose.yaml`:
```bash
docker compose up -d
```

---

### 7. Verify Deployment

1. Check if all containers are running:
   ```bash
   docker ps
   ```
   Ensure all necessary services (e.g., `cgs_assist_server`, `llm_api_server`, `rag_api_server`, etc.) appear as running. Pay attention to the health status of the containers.

2. Inspect logs for potential errors:
   ```bash
   docker logs <container-id>
   ```
   For example, if the `cgs_assist_server` exits, check its logs:
   ```bash
   docker logs shared_folder-cgs_assist_server-1
   ```

3. Make sure the exposed endpoints (e.g., `8080`, etc.,) are accessible:
   ```bash
   curl http://<server-ip>:8080
   ```
   Replace `<server-ip>` with the actual IP address or domain of the server.

---

### 8. Troubleshooting Common Issues

1. **Missing Configuration**:
   - Ensure required files like `config.yaml`, `.env`, or other configuration files exist in the shared folder.

2. **API Keys or Permissions**:
   - Confirm that environment variables for accessing services (like Azure OpenAI) are properly configured in the `.env` file.

3. **Docker Image Not Found**:
   - Ensure the correct image repository or tag is referenced in the `docker-compose.yaml`.
   - Authenticate to the correct container registry if necessary.

4. **Logs for Debugging**:
   - Check logs of specific containers for debugging:
     ```bash
     docker logs <container-id>
     ```

5. **Failed `docker compose pull` or `up`**:
   - Ensure network access on the server and that the Docker registry credentials are correct.

---

### 9. Tear Down Services (Optional)

If you need to stop/remove the services:
```bash
docker compose down
```

---

### 10. Expose the Application to the Customer

1. Confirm the services are bound to the correct server IP and port.
2. Set up a reverse proxy or firewall rules (if necessary) to expose the required services securely.

---

This completes the deployment of CGS Assist on a cloud server. Let the customer know the IP address, endpoints, and any initial setup.