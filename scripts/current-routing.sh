#!/bin/bash

echo "🌐 Current Production Routing:"
ACTIVE_SERVER=$(docker compose exec nginx cat /etc/nginx/conf.d/default.conf | grep "server" -m 1  | cut -c 12-21)
echo "$ACTIVE_SERVER"
