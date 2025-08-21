#!/bin/bash

# Load environment variables
set -a
source .env
source local.env 2>/dev/null || true
set +a

# Generate nginx config from template.conf
envsubst '${SERVER_NAME} ${SSL_CERT_FILE} ${SSL_KEY_FILE}' < nginx/template.conf > nginx/prod.conf

# Generate local config (TODO: Add SSL)
if [ ! -f nginx/local.conf ]; then
    cat > nginx/local.conf <<EOF
server {
    listen 80;
    server_name localhost;

    client_max_body_size 500M;

    location / {
        proxy_pass http://public:8081;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote-addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;

	proxy_intercept_errors on;
	error_page 500 502 503 504 = @maintenance;
    }

    location @candidate_fallback {
        proxy_pass http://candidate:8082;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote-addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;        
    }
}
EOF
fi

echo "✅ Nginx configuration generated"
