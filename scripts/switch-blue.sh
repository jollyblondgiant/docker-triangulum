#!/bin/bash

echo "🔄 Switching production to BLUE (port 8081)"

docker-compose exec nginx sed -i 's/proxy_pass http:\/\/green:8082;/proxy_pass http:\/\/blue:8081;/' /etc/nginx/conf.d/default.conf

docker-compose exec nginx nginx -s reload

echo "✅ Production now pointing to BLUE"
echo "🌐 http://localhost now routes to blue:8081"
