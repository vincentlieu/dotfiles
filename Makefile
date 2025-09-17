SCRIPTS_DIR := "${HOME}/.dotfiles/scripts"
ASDF_SCRIPT := "${SCRIPTS_DIR}/asdf.sh"
HOMEBREW_SCRIPT := "${SCRIPTS_DIR}/homebrew.sh"
LINK_SCRIPT := "${SCRIPTS_DIR}/link.sh"
UPDATE_VERSIONS_SCRIPT := "${SCRIPTS_DIR}/update-tools-versions.sh"
BACKUP_SCRIPT := "${SCRIPTS_DIR}/backup.sh"

.PHONY: bootstrap scripts_permissions link homebrew asdf update-tools-versions clean backup-list backup-restore backup-clean brew-check brew-cleanup

bootstrap:
	@echo "[ INFO ] Bootstrapping..."
	@$(MAKE) link
	@$(MAKE) homebrew
	@$(MAKE) asdf
	@echo "[ INFO ] Done!"

scripts_permissions:
	@echo "[ INFO ] Setting script execute permissions..."
	@chmod +x $(ASDF_SCRIPT)
	@chmod +x $(HOMEBREW_SCRIPT)
	@chmod +x $(LINK_SCRIPT)
	@chmod +x $(UPDATE_VERSIONS_SCRIPT)

link:
	@echo "[ INFO ] Symlinking dotfiles..."
	@chmod +x $(LINK_SCRIPT)
	@$(LINK_SCRIPT)

homebrew:
	@echo "[ INFO ] Setting up homebrew..."
	@chmod +x $(HOMEBREW_SCRIPT)
	@$(HOMEBREW_SCRIPT)

asdf:
	@echo "[ INFO ] Setting up asdf..."
	@chmod +x $(ASDF_SCRIPT)
	@$(ASDF_SCRIPT)

update-tools-versions:
	@echo "[ INFO ] Updating tool versions..."
	@chmod +x $(UPDATE_VERSIONS_SCRIPT)
	@$(UPDATE_VERSIONS_SCRIPT)

clean:
	@echo "[ INFO ] Cleaning broken symlinks..."
	@find "$(HOME)" -maxdepth 1 -name ".*" -type l ! -exec test -e {} \; -print -delete

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