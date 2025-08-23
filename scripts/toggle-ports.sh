#!/bin/bash

# Read current routing
CURRENT=$(docker compose exec nginx cat /etc/nginx/conf.d/default.conf | grep -o "server .*;" | cut -d ' ' -f2 | cut -d: -f2)

if [ "$CURRENT" = "8081" ]; then
    echo "🔄 Switching port 8080 → 8082 (GREEN)"
    TARGET="green:8082"
else
    echo "🔄 Switching port 8080 → 8081 (BLUE)"
    TARGET="blue:8081"
fi

# Update config
docker compose exec nginx sh -c "
    export CURRENT_PRODUCTION=$TARGET
    envsubst '\$CURRENT_PRODUCTION' < /etc/nginx/template.conf > /etc/nginx/conf.d/default.conf
    nginx -s reload
"

echo "✅ Port 8080 now forwarding to $TARGET"
