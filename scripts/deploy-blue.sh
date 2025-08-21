#!/bin/bash
BRANCH=${1:-$BLUE_BRANCH}

echo "📦 Deploying code to BLUE: $BRANCH"

set -a
source .env
set +a

git -C .. fetch origin
git -C .. checkout $BRANCH
git -C .. pull origin $BRANCH

docker-compose build blue
docker-compose up -d blue

echo "✅ Blue deployed: $BRANCH"
echo "🔗 Test at: http://localhost:8081"
