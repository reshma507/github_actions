#!/bin/bash
set -xe

apt-get update -y
apt-get install -y docker.io

systemctl enable docker
systemctl start docker

docker pull ${image}

docker stop strapi || true
docker rm strapi || true

docker run -d --name strapi \
  -p 1337:1337 \
  -p 80:80 \
  --restart unless-stopped \
  -e NODE_ENV=production \
  -e ADMIN_JWT_SECRET="${admin_jwt_secret}" \
  -e API_TOKEN_SALT="${api_token_salt}" \
  -e TRANSFER_TOKEN_SALT="${transfer_token_salt}" \
  -e ENCRYPTION_KEY="${encryption_key}" \
  -e APP_KEYS="${app_keys}" \
  -e DATABASE_CLIENT=postgres \
  -e DATABASE_HOST="${db_host}" \
  -e DATABASE_PORT=5432 \
  -e DATABASE_NAME=strapi \
  -e DATABASE_USERNAME=strapi \
  -e DATABASE_PASSWORD="${db_password}" \
  -e DATABASE_SSL=false \
  ${image}



