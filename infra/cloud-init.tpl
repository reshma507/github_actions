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
  -e ADMIN_AUTH_SECRET="${admin_auth_Secret}" \
  -e DATABASE_CLIENT=sqlite \
  -e DATABASE_FILENAME=.tmp/data.db \
  ${image}


