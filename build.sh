#!/usr/bin/env bash

set -euo pipefail

# --- Usage Info ---
function usage() {
    echo "Usage: $0 <directory>"
    echo "  directory : The build context directory (must contain a Containerfile or Dockerfile and optional repo.conf)"
    exit 1
}

# --- Argument Check ---
if [[ $# -ne 1 ]]; then
    usage
fi

DIR="${1%/}"  # Remove trailing slash

if [[ ! -d "$DIR" ]]; then
    echo "❌ Error: Directory '$DIR' does not exist."
    exit 1
fi

# --- Detect build file ---
BUILD_FILE=""
if [[ -f "$DIR/Containerfile" ]]; then
    BUILD_FILE="$DIR/Containerfile"
elif [[ -f "$DIR/Dockerfile" ]]; then
    BUILD_FILE="$DIR/Dockerfile"
else
    echo "❌ No Containerfile or Dockerfile found in '$DIR'."
    exit 1
fi

# --- Extract version from LABEL ---
VERSION=$(grep -i 'label.*version\s*=' "$BUILD_FILE" \
    | sed -E 's/.*version\s*=\s*["'"'"']([^"'"'"']+)["'"'"'].*/\1/i' \
    | head -n 1)

if [[ -z "$VERSION" ]]; then
    VERSION="latest"
    echo "⚠️  No version label found — using default: $VERSION"
fi

# --- Extract repo_name from repo.conf (if exists) ---
REPO=""
CONF_FILE="repo.conf"

if [[ -f "$CONF_FILE" ]]; then
    REPO=$(grep -A1 '^\[general\]' $CONF_FILE | grep '^repo_name' | cut -d '=' -f2 | xargs)
fi

if [[ -z "$REPO" ]]; then
    echo "⚠️  No repo_name found in $CONF_FILE — image will be tagged without repository"
fi

# --- Build tag ---
IMAGE_NAME=$(basename "$DIR")
if [[ -n "$REPO" ]]; then
    TAG="${REPO}/${IMAGE_NAME}:${VERSION}"
else
    TAG="${IMAGE_NAME}:${VERSION}"
fi

# --- Build Image ---
echo "🔨 Building image: $TAG"
podman build -t "$TAG" "$DIR"

if [[ $? -eq 0 ]]; then
    echo "✅ Successfully built: $TAG"
else
    echo "❌ Build failed for: $TAG"
    exit 1
fi