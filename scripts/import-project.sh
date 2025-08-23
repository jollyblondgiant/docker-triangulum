#!/bin/bash
# clones the supplied git repository into the /app/ dir

#Load environment
set -a
source .env
set +a

echo "📦 Importing project to /app/..."

git clone $GIT_REPO app/$APP_NAME
