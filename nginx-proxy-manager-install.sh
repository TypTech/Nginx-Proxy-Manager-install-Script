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
