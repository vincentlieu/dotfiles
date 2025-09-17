#! /bin/bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"

# Source backup utilities
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
# shellcheck source=./backup.sh
# shellcheck disable=SC1091
source "$SCRIPT_DIR/backup.sh"

# Symlink all dot files to the $HOME directory. i.e. .zshrc, .asdfrc etc
function symlink_dotfiles() {
    if [ ! -d "$DOTFILES_DIR" ]; then
        echo "❌ Error: Dotfiles directory not found: $DOTFILES_DIR"
        exit 1
    fi
    
    echo "🔗 Starting dotfiles symlinking..."
    
    local dotfiles_found=false
    local symlinked_count=0
    local failed_count=0
    
    # Find all dotfiles
    while IFS= read -r -d '' filepath; do
        dotfiles_found=true
        local filename
        local target
        filename=$(basename "$filepath")
        target="$HOME/$filename"
        
        echo "🔗 Processing: $filename"
        
        # Backup existing file if needed
        backup_file "$target"
        
        # Create symlink
        if ln -fs "$filepath" "$target"; then
            echo "✅ Symlinked: $filename"
            ((symlinked_count++))
        else
            echo "❌ Failed to symlink: $filename"
            ((failed_count++))
        fi
    done < <(find "$DOTFILES_DIR" -type f -name '.*' ! -name '.gitignore' ! -name '.DS_Store' -print0)
    
    if [ "$dotfiles_found" = false ]; then
        echo "⚠️  No dotfiles found in $DOTFILES_DIR"
        exit 1
    fi
    
    echo "📊 Summary:"
    echo "   ✅ Successfully symlinked: $symlinked_count files"
    if [ $failed_count -gt 0 ]; then
        echo "   ❌ Failed to symlink: $failed_count files"
        exit 1
    fi
    
    echo "🎉 All dotfiles symlinked successfully!"
}

# Main execution
function main() {
    echo "🔗 Starting dotfiles linking process..."
    create_backup_dir
    symlink_dotfiles
}

main "$@"