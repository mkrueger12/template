#!/bin/bash

# Script to copy latest config files and build Docker image
# This script copies files listed in .gitignore from the user's home directory
# and then builds the Docker image with the latest configurations

set -e  # Exit on any error

echo "🔄 Copying latest config files..."

# Copy auth.json from opencode
if [ -f "/Users/max/.local/share/opencode/auth.json" ]; then
    echo "  ✅ Copying auth.json"
    cp "/Users/max/.local/share/opencode/auth.json" .
else
    echo "  ⚠️  auth.json not found at /Users/max/.local/share/opencode/auth.json"
fi

# Copy zsh config files
if [ -f "/Users/max/.zshenv" ]; then
    echo "  ✅ Copying .zshenv"
    cp "/Users/max/.zshenv" .
else
    echo "  ⚠️  .zshenv not found"
fi

if [ -f "/Users/max/.zshrc" ]; then
    echo "  ✅ Copying .zshrc"
    cp "/Users/max/.zshrc" .
else
    echo "  ⚠️  .zshrc not found"
fi

# Copy claude config
if [ -f "/Users/max/.claude.json" ]; then
    echo "  ✅ Copying .claude.json"
    cp "/Users/max/.claude.json" .
else
    echo "  ⚠️  .claude.json not found"
fi

echo ""
echo "🐳 Building Docker image..."
docker build -t base-image:latest .

echo ""
echo "✅ Build complete! Image: base-image:latest"
echo ""
echo "🚀 To run the container:"
echo "  docker run -it --rm base-image:latest zsh"