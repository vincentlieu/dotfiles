#!/bin/bash
# Backup utility functions for dotfiles management
# Source this file to use these functions

set -euo pipefail

# Default backup directory
BACKUP_DIR="${BACKUP_DIR:-$HOME/.dotfiles-backup}"

# Create backup directory if it doesn't exist
function create_backup_dir() {
    if [ ! -d "$BACKUP_DIR" ]; then
        echo "📁 Creating backup directory: $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
    fi
}

# Backup existing file if it exists and is not a symlink
function backup_file() {
    local target_file="$1"
    local filename
    filename=$(basename "$target_file")
    
    if [ -e "$target_file" ] && [ ! -L "$target_file" ]; then
        echo "💾 Backing up existing file: $filename"
        local timestamp
        timestamp=$(date +%Y%m%d_%H%M%S)
        cp "$target_file" "$BACKUP_DIR/$filename.$timestamp"
        return 0
    fi
    return 1
}

# Backup multiple files
function backup_files() {
    local backed_up_count=0
    
    for file in "$@"; do
        if backup_file "$file"; then
            ((backed_up_count++))
        fi
    done
    
    if [ $backed_up_count -gt 0 ]; then
        echo "💾 Backed up $backed_up_count files to $BACKUP_DIR"
    fi
    
    return 0
}

# List all backup files
function list_backups() {
    if [ ! -d "$BACKUP_DIR" ]; then
        echo "No backup directory found at: $BACKUP_DIR"
        return 1
    fi
    
    echo "📋 Backup files in $BACKUP_DIR:"
    ls -la "$BACKUP_DIR"
}

# Restore a file from backup (interactive)
function restore_file() {
    local filename="$1"
    local target_file="$HOME/$filename"
    
    if [ ! -d "$BACKUP_DIR" ]; then
        echo "❌ No backup directory found at: $BACKUP_DIR"
        return 1
    fi
    
    # Find backup files for this filename
    local backup_files
    backup_files=$(find "$BACKUP_DIR" -name "$filename.*" -type f | sort -r)
    
    if [ -z "$backup_files" ]; then
        echo "❌ No backup found for: $filename"
        return 1
    fi
    
    echo "📋 Available backups for $filename:"
    echo "$backup_files" | nl
    
    read -p "Select backup number to restore (or 0 to cancel): " -r choice
    
    if [ "$choice" = "0" ]; then
        echo "Restore cancelled"
        return 0
    fi
    
    local selected_backup
    selected_backup=$(echo "$backup_files" | sed -n "${choice}p")
    
    if [ -z "$selected_backup" ]; then
        echo "❌ Invalid selection"
        return 1
    fi
    
    echo "🔄 Restoring $filename from $(basename "$selected_backup")"
    cp "$selected_backup" "$target_file"
    echo "✅ Restored: $filename"
}

# Clean old backups (keep only N most recent)
function clean_old_backups() {
    local keep_count="${1:-5}"
    
    if [ ! -d "$BACKUP_DIR" ]; then
        echo "No backup directory found at: $BACKUP_DIR"
        return 0
    fi
    
    echo "🧹 Cleaning old backups (keeping $keep_count most recent per file)..."
    
    # Get unique base filenames
    local base_files
    base_files=$(find "$BACKUP_DIR" -type f -name "*.*" -print0 | xargs -0 -n1 basename | sed 's/\.[0-9_]*$//' | sort -u)
    
    local cleaned_count=0
    
    for base_file in $base_files; do
        # Find all backups for this base file, sort by date (newest first)
        local backups
        backups=$(find "$BACKUP_DIR" -name "$base_file.*" -type f | sort -r)
        
        # Skip the first N (most recent) and delete the rest
        local to_delete
        to_delete=$(echo "$backups" | tail -n +$((keep_count + 1)))
        
        if [ -n "$to_delete" ]; then
            echo "$to_delete" | while read -r backup_file; do
                echo "🗑️  Removing old backup: $(basename "$backup_file")"
                rm "$backup_file"
                ((cleaned_count++))
            done
        fi
    done
    
    if [ $cleaned_count -gt 0 ]; then
        echo "✅ Cleaned $cleaned_count old backup files"
    else
        echo "ℹ️  No old backups to clean"
    fi
}