#!/bin/bash
# Platform Engineer Script: Deploy to Production
# Usage: ./scripts/deploy-prod.sh <image-tag>
# Example: ./scripts/deploy-prod.sh main-abc123

set -e  # Exit on any error

IMAGE_TAG=$1

if [ -z "$IMAGE_TAG" ]; then
    echo "❌ Error: Image tag is required for production deployments"
    echo "Usage: ./scripts/deploy-prod.sh <image-tag>"
    echo "Example: ./scripts/deploy-prod.sh main-abc123"
    exit 1
fi

echo "🚨 Platform Engineer: Deploying to PRODUCTION"
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

# Manual approval gate
echo ""
read -p "⚠️  Are you sure you want to deploy to PRODUCTION? (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "❌ Production deployment cancelled"
    exit 1
fi

echo ""
echo "📋 Deploying with Helm..."

# Deploy using Helm
helm upgrade --install weather-app ./helm/weather-app \
  --namespace prod \
  --values ./helm/weather-app/values-prod.yaml \
  --set image.tag=$IMAGE_TAG \
  --wait \
  --timeout 5m

echo ""
echo "🔍 Verifying deployment..."
kubectl get pods -n prod
echo ""
kubectl rollout status deployment/weather-app -n prod

echo ""
echo "✅ Successfully deployed to PRODUCTION"
echo "📊 Deployment info:"
kubectl get deployment weather-app -n prod
echo ""
echo "🌐 To access: kubectl port-forward svc/weather-app-service 18082:80 -n prod"
