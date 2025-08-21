#!/bin/bash

echo "🔄 Switching production to GREEN (port 8082)"

# Update nginx config to point to blue
docker-compose exec nginx sh -c "
    export TARGET_SERVER=green:8082
    envsubst '\$TARGET_SERVER' < /etc/nginx/template.conf > /etc/nginx/conf.d/default.conf
    nginx -s reload
"

echo "✅ Production now pointing to GREEN"
echo "🌐 http://localhost now routes to green:8082"
