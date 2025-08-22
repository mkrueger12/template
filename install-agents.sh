#!/bin/bash

# Script to copy ocode-agents files to opencode config directory
# Usage: ./install-agents.sh

SOURCE_DIR="$(dirname "$0")/ocode-agents"
DEST_DIR="/Users/max/.config/opencode/agent"

echo "Copying agents from $SOURCE_DIR to $DEST_DIR..."

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Copy all files from ocode-agents to the destination
cp -r "$SOURCE_DIR"/* "$DEST_DIR/"

if [ $? -eq 0 ]; then
    echo "✅ Successfully copied agents to $DEST_DIR"
else
    echo "❌ Error copying agents"
    exit 1
fi
