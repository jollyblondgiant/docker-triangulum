#!/bin/bash
# clones the supplied git repository into the /app/ dir

#Load environment
set -a
source .env
set +a

GIT_REPO=${1}

if [ -z "$GIT_REPO" ]; then
    echo "❌ Usage: ./scripts/import-project.sh <git-repo> "
    exit 1
fi

echo "📦 Importing project to /app/..."

git clone $GIT_REPO app/$APP_NAME
