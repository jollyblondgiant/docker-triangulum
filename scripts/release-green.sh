#!/bin/bash

echo "🔄 Switching production to GREEN (port 8082)"

docker compose exec nginx /bin/sh -c "export TARGET_SERVER=green:8082 && envsubst '\$TARGET_SERVER' < /etc/nginx/templates/sig-app.conf.template > /etc/nginx/conf.d/default.conf && nginx -s reload"

echo "✅ Production now pointing to GREEN"
echo "🌐 http://localhost now routes to green:8082"
