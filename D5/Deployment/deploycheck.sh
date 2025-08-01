#!/bin/bash

# Usage: ./deploy_check.sh <environment>
# Example: ./deploy_check.sh staging

ENV=$1

if [[ -z "$ENV" ]]; then
  echo "Usage: $0 <environment>"
  exit 1
fi

# Define environment-specific variables
if [[ "$ENV" == "prod" ]]; then
  BASE_URL="https://google.com"
elif [[ "$ENV" == "staging" ]]; then
  BASE_URL="https://yahoo.com"
elif [[ "$ENV" == "dev" ]]; then
  BASE_URL="https://rediffmail.com"
else
  echo "Unknown environment: $ENV"
  exit 2
fi

echo "Running deployment checks for environment: $ENV ($BASE_URL)"

# Example: Check service health endpoint
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/health")

if [[ "$STATUS" == "200" ]]; then
  echo "Deployment check passed: Service is healthy (HTTP $STATUS)"
  exit 0
else
  echo "Deployment check FAILED: Service not healthy (HTTP $STATUS)"
  exit 3
fi
