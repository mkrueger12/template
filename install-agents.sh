#!/bin/bash

# Script to copy ocode-agents files to opencode config directory
# Usage: ./install-agents.sh

SOURCE_DIR="$(dirname "$0")/opencode/agents"
CONFIG_FILE="$(dirname "$0")/opencode/opencode.json"
DEST_DIR="/Users/max/.config/opencode/agent"
CONFIG_DEST_DIR="/Users/max/.config/opencode"

echo "Copying agents from $SOURCE_DIR to $DEST_DIR..."
echo "Copying config from $CONFIG_FILE to $CONFIG_DEST_DIR..."

# Create destination directories if they don't exist
mkdir -p "$DEST_DIR"
mkdir -p "$CONFIG_DEST_DIR"

# Copy all files from agents directory to the destination
cp -r "$SOURCE_DIR"/* "$DEST_DIR/"

# Copy the config file
cp "$CONFIG_FILE" "$CONFIG_DEST_DIR/"

if [ $? -eq 0 ]; then
    echo "✅ Successfully copied agents to $DEST_DIR"
    echo "✅ Successfully copied config to $CONFIG_DEST_DIR"
else
    echo "❌ Error copying files"
    exit 1
fi
