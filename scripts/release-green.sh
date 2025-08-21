#!/bin/bash

echo "=== Switching Production to Green ==="

docker-compose exec nginx /bin/sh -c "
sed -i 's/proxy_pass http:\\/\\/blue:8081;/proxy_pass http:\\/\\/green:8082;/' /etc/nginx/conf.d/default.conf &&
nginx -s reload
"

echo "✅ Production now serving from Green"
