#!/bin/bash

# Load environment
source .env
source local.env 2>/dev/null || true

# Generate nginx config
#./scripts/gen-nginx.sh

# Setup SSL
#./scripts/setup-ssl.sh

# Start services
echo "Starting services for ${SERVER_NAME}..."
docker compose --profile green --profile blue up -d --build

echo "✅ Services started for ${SERVER_NAME}"
echo "Access at: http://${SERVER_NAME}"
