#!/bin/bash

set -a
source .env
set +a
BRANCH=${1:-$GREEN_BRANCH}

echo "📦 Deploying code to GREEN: $BRANCH"

git -C .. fetch origin
git -C .. checkout $BRANCH
git -C .. pull origin $BRANCH

docker-compose build green
docker-compose up -d green

echo "✅ Green deployed: $BRANCH"
echo "🔗 Test at: http://localhost:8082"

