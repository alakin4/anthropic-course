#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Build and run your Docker image locally with environment-aware logic.
# First, run chmod +x docker-dev.sh
#
# USAGE EXAMPLES:
# 1. Build for production (ENV=base), run with default GREETING or .env
#   ./docker-dev.sh
#
# 2. Build with dev environment (includes tests/)
#   ENV=dev ./docker-dev.sh
#
# 3. Override greeting inline for this run
#   GREETING="👋 Hello!" ./docker-dev.sh
#
# 4. Drop into an interactive /bin/bash shell in the container
#   ./docker-dev.sh --interactive
#   ./docker-dev.sh -i
#
# 5. Build dev image, then run interactively
#   ENV=dev ./docker-dev.sh --interactive
# 6. Build dev image, then run interactively with custom .env
#   ENV_FILE=".env" ./docker-dev.sh --interactive
# ------------------------------------------------------------------------------

set -euo pipefail

# -------------------------
# CONFIG
# -------------------------
IMAGE_NAME="python-template"
ENV_MODE="${ENV:-dev}"     # set ENV=dev for dev build
GREETING="${GREETING:-"Hello from shell script!"}"
ENV_FILE=".env"
INTERACTIVE=false

# -------------------------
# Parse flags
# -------------------------
for arg in "$@"; do
  if [[ "$arg" == "--interactive" || "$arg" == "-i" ]]; then
    INTERACTIVE=true
  fi
done

echo "🛠️ Building Docker image with ENV_MODE=$ENV_MODE"

# -------------------------
# Build Docker image
# -------------------------
DOCKER_BUILDKIT=1 docker build \
  --build-arg ENV_MODE="$ENV_MODE" \
  -t "$IMAGE_NAME:$ENV_MODE" .

echo "✅ Build complete: $IMAGE_NAME:$ENV_MODE"

# -------------------------
# Prepare env args
# -------------------------
if [[ -f "$ENV_FILE" ]]; then
  echo "📦 Using $ENV_FILE for environment variables"
  ENV_ARG="--env-file $ENV_FILE"
else
  echo "⚠️ No .env found — falling back to inline GREETING"
  ENV_ARG="-e GREETING=$GREETING"
fi

# -------------------------
# Run container
# -------------------------
if [[ "$INTERACTIVE" == true ]]; then
  echo "🧪 Running container in interactive shell mode..."
  docker run -it --rm $ENV_ARG "$IMAGE_NAME:$ENV_MODE" /bin/bash
else
  echo "🚀 Running container normally..."
  docker run --rm $ENV_ARG "$IMAGE_NAME:$ENV_MODE"
fi
