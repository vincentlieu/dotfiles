SCRIPTS_DIR := "${HOME}/.dotfiles/scripts"
ASDF_SCRIPT := "${SCRIPTS_DIR}/asdf.sh"
HOMEBREW_SCRIPT := "${SCRIPTS_DIR}/homebrew.sh"
LINK_SCRIPT := "${SCRIPTS_DIR}/link.sh"
UPDATE_VERSIONS_SCRIPT := "${SCRIPTS_DIR}/update-tools-versions.sh"

.PHONY: bootstrap scripts_permissions link homebrew asdf update-tools-versions clean

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