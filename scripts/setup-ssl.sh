#!/bin/bash

# Load environment variables
set -a
source .env
source local.env 2>/dev/null || true
set +a

mkdir -p ssl ssl-private

# Generate self-signed cert for local development if needed
if ["$SERVER_NAME" = "localhost" ] && [ ! -f ssl/localhost.crt ]; then
    echo "Generating self-signed cert for localhost..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	    -keyout ssl-private/localhost.key \
	    -out ssl/localhost.crt \
	    -subj "/CN=localhost"
    echo "✅ Self-signed SSL certificate generated"
fi

echo "SSL files:"
ls -la ssl/ ssl-private/
    
