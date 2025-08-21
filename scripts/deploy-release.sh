#!/bin/bash

RELEASE_BRANCH=${1}
ENVIRONMENT=${2:-green}

if [ -z "$RELEASE_BRANCH" ]; then
    echo "❌ Usage: ./scripts/deploy-release.sh <release-branch> [blue|green]"
    exit 1
fi

echo "🚀 Deploying $RELEASE_BRANCH to $ENVIRONMENT"

if [ "$ENVIRONMENT" = "green" ]; then
    ./scripts/deploy-green.sh $RELEASE_BRANCH
    echo "📋 Next step: Test green at http://localhost:8082"
    echo "📋 Then promote: ./scripts/route-to-green.sh"
else
    ./scripts/deploy-blue.sh $RELEASE_BRANCH
    echo "📋 Next step: Test blue at http://localhost:8081"
    echo "📋 Then promote: ./scripts/route-to-blue.sh"
fi
