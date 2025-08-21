#!/bin/bash

echo "🔄 Switching production to GREEN (port 8082)"

docker-compose exec nginx sed -i 's/proxy_pass http:\/\/blue:8081;/proxy_pass http:\/\/green:8082;/' /etc/nginx/conf.d/default.conf

docker-compose exec nginx nginx -s reload

echo "✅ Production now pointing to GREEN"
echo "🌐 http://localhost now routes to green:8082"
