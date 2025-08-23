#!/bin/bash

echo "🌐 Current Production Routing:"
docker compose exec nginx cat /etc/nginx/conf.d/default.conf | grep "proxy_pass" | cut -d ' ' -f2
