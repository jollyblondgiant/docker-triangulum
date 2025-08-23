#!/bin/bash
BRANCH=${1:-$BLUE_BRANCH}
set -a; source .env; set +a

echo "📦 Deploying code to BLUE: $BRANCH"
set -a; source .env; set +a

if [ "$1" != "" ]; then
    sed -i "s/^BLUE_BRANCH=.*/BLUE_BRANCH=$BRANCH/" .env
fi

# Rebuild with new branch
docker compose build --build-arg GIT_BRANCH=$BRANCH blue
docker compose up -d blue

echo "✅ Blue deployed: $BRANCH"
echo "🔗 Test at: http://localhost:8081"
