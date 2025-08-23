#!/bin/bash
BRANCH=${1:-$GREEN_BRANCH}
set -a ; source .env; set +a

echo "📦 Deploying code to GREEN: $BRANCH"
set -a; source .env; set +a

if [ "$1" != "" ]; then
    sed -i "s/^GREEN_BRANCH=.*/GREEN_BRANCH=$BRANCH/" .env
fi

# Rebuild with new branch
docker compose build --build-arg GIT_BRANCH=$BRANCH green
docker compose up -d green

echo "✅ Green deployed: $BRANCH"
echo "🔗 Test at: http://localhost:8082"

