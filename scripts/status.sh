#!/bin/bash

set -a
source .env
set +a

echo "🎯 Current Status:"
echo "🔵 BLUE: $BLUE_BRANCH (http://localhost:8081)"
echo "🟢 GREEN: $GREEN_BRANCH (http://localhost:8082)"

CURRENT_ROUTE=$(docker compose exec nginx cat /etc/nginx/conf.d/default.conf | grep "proxy_pass" | cut -d' ' -f2)

echo "🌐 PRODUCTION ROUTING: $CURRENT_ROUTE"

echo -e "\n 📦 Container Status:"
docker compose ps --service | xargs -I {} sh -c 'echo " {}: $(docker compose ps -q {} | xargs docker inspect -f "{{.State.Status}}")"'

