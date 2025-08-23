#!/bin/bash

echo "🔄 Switching production to BLUE (port 8081)"

docker compose exec nginx /bin/sh -c "export TARGET_SERVER=blue:8081 && envsubst '\$TARGET_SERVER' < /etc/nginx/templates/sig-app.conf.template > /etc/nginx/conf.d/default.conf && nginx -s reload"

echo "✅ Production now pointing to BLUE"
echo "🌐 http://localhost now routes to blue:8081"
