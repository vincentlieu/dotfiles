SCRIPTS_DIR := "${HOME}/.dotfiles/scripts"
HOMEBREW_SCRIPT := "${SCRIPTS_DIR}/homebrew.sh"
LINK_SCRIPT := "${SCRIPTS_DIR}/link.sh"
BACKUP_SCRIPT := "${SCRIPTS_DIR}/backup.sh"

.PHONY: bootstrap scripts_permissions link unlink homebrew brew-check brew-cleanup backup-list backup-restore backup-clean doctor

bootstrap:
	@echo "[ INFO ] Bootstrapping..."
	@$(MAKE) link
	@$(MAKE) homebrew
	@echo "[ INFO ] Done!"

scripts_permissions:
	@echo "[ INFO ] Setting script execute permissions..."
	@chmod +x $(HOMEBREW_SCRIPT)
	@chmod +x $(LINK_SCRIPT)

link:
	@echo "[ INFO ] Symlinking dotfiles..."
	@chmod +x $(LINK_SCRIPT)
	@$(LINK_SCRIPT)

unlink:
	@echo "[ INFO ] Removing dotfile symlinks..."
	@stow -D -t "$(HOME)" -d "$(HOME)/.dotfiles" home
	@stow -D -t "$(HOME)/.config" -d "$(HOME)/.dotfiles" config
	@echo "[ INFO ] Done!"

homebrew:
	@echo "[ INFO ] Setting up homebrew..."
	@chmod +x $(HOMEBREW_SCRIPT)
	@$(HOMEBREW_SCRIPT)

brew-check:
	@echo "[ INFO ] Checking Brewfile package status..."
	@if command -v brew >/dev/null 2>&1; then \
		brew bundle check --global --verbose; \
	else \
		echo "❌ Homebrew not installed"; \
		exit 1; \
	fi

brew-cleanup:
	@echo "[ INFO ] Cleaning up Homebrew..."
	@if command -v brew >/dev/null 2>&1; then \
		brew bundle cleanup --global --force; \
		brew cleanup; \
		brew autoremove; \
	else \
		echo "❌ Homebrew not installed"; \
		exit 1; \
	fi

backup-list:
	@echo "[ INFO ] Listing backup files..."
	@chmod +x $(BACKUP_SCRIPT)
	@$(BACKUP_SCRIPT) -c "list_backups" || (source $(BACKUP_SCRIPT) && list_backups)

backup-restore:
	@echo "[ INFO ] Interactive backup restore..."
	@chmod +x $(BACKUP_SCRIPT)
	@echo "Available backup files:" && ls -la ~/.dotfiles-backup/ 2>/dev/null || echo "No backups found"
	@read -p "Enter filename to restore (without timestamp): " filename && \
	source $(BACKUP_SCRIPT) && restore_file "$$filename"

backup-clean:
	@echo "[ INFO ] Cleaning old backup files..."
	@chmod +x $(BACKUP_SCRIPT)
	@source $(BACKUP_SCRIPT) && clean_old_backups 5

doctor:
	@echo "[ INFO ] Running dotfiles health check..."
	@echo ""
	@echo "📦 Core Tools:"
	@command -v brew >/dev/null 2>&1 && echo "  ✅ Homebrew installed" || echo "  ❌ Homebrew missing"
	@command -v mise >/dev/null 2>&1 && echo "  ✅ mise installed" || echo "  ❌ mise missing"
	@command -v stow >/dev/null 2>&1 && echo "  ✅ stow installed" || echo "  ❌ stow missing"
	@command -v git >/dev/null 2>&1 && echo "  ✅ git installed" || echo "  ❌ git missing"
	@command -v zsh >/dev/null 2>&1 && echo "  ✅ zsh installed" || echo "  ❌ zsh missing"
	@echo ""
	@echo "🔗 Dotfile Symlinks:"
	@test -L ~/.zshrc && echo "  ✅ .zshrc symlinked" || echo "  ⚠️  .zshrc not symlinked"
	@test -L ~/.gitconfig && echo "  ✅ .gitconfig symlinked" || echo "  ⚠️  .gitconfig not symlinked"
	@test -L ~/.config/mise && echo "  ✅ mise config symlinked" || echo "  ⚠️  mise config not symlinked"
	@echo ""
	@echo "🛠️  mise status:"
	@if command -v mise >/dev/null 2>&1; then \
		mise list 2>/dev/null || echo "  ⚠️  No mise tools installed"; \
	else \
		echo "  ⚠️  mise not available"; \
	fi
	@echo ""
	@echo "✅ Health check complete!"
