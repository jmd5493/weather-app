#!/bin/bash
# Platform Engineer Script: Get latest image tag from CI
# This simulates checking GitHub Actions for the latest successful build

echo "🔍 Checking latest CI build..."
echo ""

# Get the latest commit SHA (what CI just built)
LATEST_SHA=$(git rev-parse --short HEAD)
IMAGE_TAG="main-$LATEST_SHA"

echo "📦 Latest image tag: $IMAGE_TAG"
echo "🔗 Full image: jamesmd1996/weather-app:$IMAGE_TAG"
echo ""

# Check if it exists in Docker Hub
echo "🔍 Verifying in Docker Hub..."
if docker manifest inspect jamesmd1996/weather-app:$IMAGE_TAG > /dev/null 2>&1; then
    echo "✅ Image exists and ready to deploy"
    echo ""
    echo "To deploy to dev:"
    echo "  ./scripts/deploy-dev.sh $IMAGE_TAG"
    echo ""
    echo "To deploy to prod:"
    echo "  ./scripts/deploy-prod.sh $IMAGE_TAG"
else
    echo "⏳ Image not yet available (CI may still be building)"
    echo "💡 Check GitHub Actions: https://github.com/YOUR-USERNAME/weather-app/actions"
fi
