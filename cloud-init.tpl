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
  ${image}
