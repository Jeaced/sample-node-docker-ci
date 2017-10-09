#!/bin/bash
docker push jeaced/sample-node

ssh sergey_umnov@35.195.239.193 << EOF
sudo docker pull jeaced/sample-node:latest
sudo docker stop web || true
sudo docker rm web || true
sudo docker rmi jeaced/sample-node:current || true
sudo docker tag jeaced/sample-node:latest jeaced/sample-node:current
sudo docker run -d --restart always --name web -p 80:80 jeaced/sample-node:current
EOF