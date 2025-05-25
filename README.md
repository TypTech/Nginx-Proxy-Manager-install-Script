
# 🚀 Nginx Proxy Manager Install Script (Debian / Proxmox LXC)

This repository provides a simple bash script to install [Nginx Proxy Manager](https://nginxproxymanager.com/) using Docker and Docker Compose on any **Debian-based system**, including **Proxmox LXC containers**.

---

## 📋 Features

- Automated installation of Docker and Docker Compose
- Pulls and runs the official Nginx Proxy Manager image
- Sets up required ports (80, 81, 443)
- Stores data in `/opt/npm`

---

## 📦 Installation

### 1. Download or create the script

```bash
nano nginx-proxy-manager-install.sh
```

Paste the following content into the file:  
👉 [See nginx-proxy-manager-install.sh script](#nginx-proxy-manager-install.sh)

Save and exit (`CTRL+O`, `Enter`, `CTRL+X`).

### 2. Make the script executable

```bash
chmod +x nginx-proxy-manager-install.sh
```

### 3. Run the script

```bash
./nginx-proxy-manager-install.sh
```

---

## 🌐 Access the Web UI

After installation, open your browser and go to:

```
http://<your-container-ip>:81
```

> Replace `<your-container-ip>` with the actual IP address of your container.

### 🔐 Default Login Credentials

- **Email:** `admin@example.com`  
- **Password:** `changeme`

You will be asked to update the credentials on first login.

---

## 🛠️ Data Storage

Nginx Proxy Manager will store its configuration and SSL certificates in:

- `/opt/npm/data`
- `/opt/npm/letsencrypt`

---

## ❌ Uninstall Instructions

To stop and remove the container:

```bash
cd /opt/npm
docker compose down -v
```

To remove Docker volumes:

```bash
docker volume prune
```

To remove the install folder:

```bash
rm -rf /opt/npm
```

---

## 📝 Script: `nginx-proxy-manager-install.sh`

```bash
#!/bin/bash

# Update & install dependencies
apt update && apt install -y curl sudo gnupg2 ca-certificates lsb-release software-properties-common

# Install Docker
curl -fsSL https://get.docker.com | sh

# Install Docker Compose plugin
apt install -y docker-compose-plugin

# Create project directory
mkdir -p /opt/npm
cd /opt/npm

# Create docker-compose.yml
cat <<EOF > docker-compose.yml
version: '3'
services:
  npm:
    image: jc21/nginx-proxy-manager:latest
    container_name: nginx-proxy-manager
    restart: always
    ports:
      - "80:80"
      - "81:81"
      - "443:443"
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
EOF

# Start Nginx Proxy Manager
docker compose up -d

echo "✅ Nginx Proxy Manager installation complete!"
echo "➡ Access the dashboard at: http://<your-container-ip>:81"
echo "🔑 Default login: admin@example.com / changeme"
```

---

## 📞 Support

If you run into issues or want to extend the setup (e.g. with Cloudflare DDNS, SSL, or IPv6), feel free to open an issue or ask for help!
