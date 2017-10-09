#!/bin/bash
docker push jeaced/sample-node

ssh sergey_umnov@35.195.239.193 << EOF
su -l root
docker pull jeaced/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi jeaced/sample-node:current || true
docker tag jeaced/sample-node:latest jeaced/sample-node:current
docker run -d --restart always --name web -p 80:80 jeaced/sample-node:current
EOF