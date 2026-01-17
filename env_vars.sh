#!/bin/bash

# Check if .env file exists
if [ -f ".env" ]; then
    echo "Reading from .env file..."
    
    # Read and export variables from .env file
    while IFS='=' read -r key value || [[ -n $key ]]; do
        # Skip comments and empty lines
        [[ $key =~ ^[[:space:]]*# ]] && continue
        [[ -z $key ]] && continue

        # Remove surrounding quotes from value if present
        value=$(echo "$value" | sed 's/^["'\'']//' | sed 's/["'\'']$//')

        # Export the variable
        export "$key=$value"
        echo "Exported: $key"
    done < .env
    
    echo "Environment variables loaded from .env file"
else
    echo "Error: .env file not found. Please create it first."
    exit 1
fi

if [ -n "$CLAUDE_ENV_FILE" ]; then
    echo "Appending to CLAUDE_ENV_FILE: $CLAUDE_ENV_FILE"
    
    # Read .env and prepend export to each line before writing to CLAUDE_ENV_FILE
    while IFS='=' read -r key value || [[ -n $key ]]; do
        # Skip comments and empty lines
        [[ $key =~ ^[[:space:]]*# ]] && continue
        [[ -z $key ]] && continue

        # Remove surrounding quotes from value if present
        value=$(echo "$value" | sed 's/^["'\'']//' | sed 's/["'\'']$//')

        # Write with export prefix
        echo "export $key=$value" >> "$CLAUDE_ENV_FILE"
    done < .env
fi

exit 0