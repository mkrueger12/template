#!/bin/bash

# Script to convert agents from opencode/agent/ to .claude/agents format
set -e

SOURCE_DIR="opencode/agent"
DEST_DIR=".claude/agents"

# Function to extract description from existing header
extract_description() {
    local file="$1"
    local desc=""
    
    # Look for description line in YAML header
    if grep -q "^description:" "$file"; then
        desc=$(grep "^description:" "$file" | sed 's/^description: //' | sed 's/^"//' | sed 's/"$//')
    fi
    
    # If no description found, create one from filename
    if [ -z "$desc" ]; then
        local basename=$(basename "$file" .md)
        desc="Agent for ${basename//-/ }"
    fi
    
    echo "$desc"
}

# Function to extract and convert tools from existing header
extract_tools() {
    local file="$1"
    local tools=""
    
    # Check if file has tools section
    if grep -q "^tools:" "$file"; then
        # Extract tools that are set to true
        local in_tools=false
        while IFS= read -r line; do
            if [[ "$line" =~ ^tools: ]]; then
                in_tools=true
                continue
            fi
            
            if [[ "$line" =~ ^--- ]] && $in_tools; then
                break
            fi
            
            if [[ "$line" =~ ^[a-zA-Z] ]] && $in_tools; then
                break
            fi
            
            if $in_tools && [[ "$line" =~ ^[[:space:]]+([a-z]+):[[:space:]]+true ]]; then
                local tool=$(echo "$line" | sed 's/^[[:space:]]*//' | sed 's/:.*//')
                case "$tool" in
                    "read") tools="${tools}Read, " ;;
                    "write") tools="${tools}Write, " ;;
                    "edit") tools="${tools}Edit, " ;;
                    "ls") tools="${tools}LS, " ;;
                    "grep") tools="${tools}Grep, " ;;
                    "glop"|"glob") tools="${tools}Glob, " ;;
                    "bash") tools="${tools}Bash, " ;;
                    "todowrite") tools="${tools}TodoWrite, " ;;
                    "todoread") tools="${tools}TodoRead, " ;;
                    *) tools="${tools}${tool^}, " ;;
                esac
            fi
        done < "$file"
    fi
    
    # Remove trailing comma and space
    tools=$(echo "$tools" | sed 's/, $//')
    
    # Default tools if none found
    if [ -z "$tools" ]; then
        tools="Read, Grep, Glob, LS"
    fi
    
    echo "$tools"
}

# Function to extract body content (everything after the YAML header)
extract_body() {
    local file="$1"
    
    # Find the end of YAML header (second ---)
    local line_num=$(awk '/^---/{count++; if(count==2) {print NR; exit}}' "$file")
    
    if [ -n "$line_num" ]; then
        # Extract everything after the second ---
        tail -n +$((line_num + 1)) "$file"
    else
        # If no proper YAML header, return whole file
        cat "$file"
    fi
}

# Function to convert a single agent file
convert_agent() {
    local source_file="$1"
    local filename=$(basename "$source_file")
    local agent_name=$(basename "$source_file" .md)
    local dest_file="$DEST_DIR/$filename"
    
    echo "Converting: $source_file -> $dest_file"
    
    # Extract components
    local description=$(extract_description "$source_file")
    local tools=$(extract_tools "$source_file")
    local body=$(extract_body "$source_file")
    
    # Create new file with Claude format
    cat > "$dest_file" << EOF
---
name: $agent_name
description: $description
tools: $tools
---

$body
EOF
    
    echo "  ✓ Converted $agent_name"
}

# Main script
main() {
    echo "Converting agents from $SOURCE_DIR to $DEST_DIR"
    echo "================================================"
    
    # Check source directory exists
    if [ ! -d "$SOURCE_DIR" ]; then
        echo "Error: Source directory $SOURCE_DIR does not exist"
        exit 1
    fi
    
    # Create destination directory
    mkdir -p "$DEST_DIR"
    echo "✓ Created destination directory: $DEST_DIR"
    
    # Find all .md files in source directory
    local agent_files=($(find "$SOURCE_DIR" -name "*.md" -type f))
    
    if [ ${#agent_files[@]} -eq 0 ]; then
        echo "No agent files found in $SOURCE_DIR"
        exit 1
    fi
    
    echo "Found ${#agent_files[@]} agent files to convert"
    echo ""
    
    # Convert each file
    for file in "${agent_files[@]}"; do
        convert_agent "$file"
    done
    
    echo ""
    echo "================================================"
    echo "✓ Conversion complete! Converted ${#agent_files[@]} files"
    echo "  Source: $SOURCE_DIR"
    echo "  Destination: $DEST_DIR"
}

# Run main function
main "$@"