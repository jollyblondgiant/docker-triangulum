#!/bin/bash

TARGET_PORT=${1:-8081}

if [ "$TARGET_PORT" = "8081" ]; then
    TARGET="blue:8081"
    echo "🔵 Setting port 8080 -> 8081 (BLUE)"
elif [ "$TARGET_PORT" = "8082" ]; then
    TARGET="green:8082"
    echo "🟢 Setting port 8080 -> 8082 (GREEN)"
else
    echo "❌ Invalid port. Use 8081 or 8082"
    exit 1
fi

docker compose exec nginx sh -c "
    export CURRENT_PRODUCTION=$TARGET
    envsubst '\$CURRENT_PRODUCTION < /etc/nginx/template.conf > /etc/nginx/conf.d/default.conf
    nginx -s reload
"

echo "✅ Port 8080 -> $TARGET_PORT forwarding active"
