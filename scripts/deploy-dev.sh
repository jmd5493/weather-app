#!/bin/bash
# Platform Engineer Script: Deploy to Dev Environment
# Usage: ./scripts/deploy-dev.sh <image-tag>
# Example: ./scripts/deploy-dev.sh main-abc123

set -e  # Exit on any error

IMAGE_TAG=${1:-latest}

echo "🚀 Platform Engineer: Deploying to DEV environment"
echo "📦 Image tag: $IMAGE_TAG"
echo ""

# Verify image exists in Docker Hub
echo "🔍 Verifying image exists..."
if docker manifest inspect jamesmd1996/weather-app:$IMAGE_TAG > /dev/null 2>&1; then
    echo "✅ Image found: jamesmd1996/weather-app:$IMAGE_TAG"
else
    echo "❌ Error: Image jamesmd1996/weather-app:$IMAGE_TAG not found in registry"
    exit 1
fi

echo ""
echo "📋 Deploying with Helm..."

# Deploy using Helm
helm upgrade --install weather-app ./helm/weather-app \
  --namespace dev \
  --values ./helm/weather-app/values-dev.yaml \
  --set image.tag=$IMAGE_TAG \
  --wait \
  --timeout 5m

echo ""
echo "🔍 Verifying deployment..."
kubectl get pods -n dev
echo ""
kubectl rollout status deployment/weather-app -n dev

echo ""
echo "✅ Successfully deployed to DEV"
echo "🌐 To access: kubectl port-forward svc/weather-app-service 18081:80 -n dev"
