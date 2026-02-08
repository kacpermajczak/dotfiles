# Dotfiles Makefile
# Simplified commands for managing dotfiles and Homebrew packages

.PHONY: help install update brew-install brew-check brew-update brew-cleanup git-status git-push clean claude-check

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

## help: Show this help message (default target)
help:
	@echo "$(BLUE)Dotfiles Management Commands$(NC)"
	@echo ""
	@echo "$(GREEN)Setup & Installation:$(NC)"
	@echo "  make install        - Install/update dotfiles (runs ./install)"
	@echo "  make update         - Pull latest changes and reinstall"
	@echo ""
	@echo "$(GREEN)Homebrew Package Management:$(NC)"
	@echo "  make brew-install   - Install all packages from Brewfile"
	@echo "  make brew-check     - Check what packages are missing"
	@echo "  make brew-update    - Update Brewfile with currently installed packages"
	@echo "  make brew-cleanup   - Remove packages not in Brewfile"
	@echo ""
	@echo "$(GREEN)Git Operations:$(NC)"
	@echo "  make git-status     - Show git status"
	@echo "  make git-push       - Push all commits to origin"
	@echo ""
	@echo "$(GREEN)Verification:$(NC)"
	@echo "  make claude-check   - Verify Claude Code installation and configuration"
	@echo ""
	@echo "$(GREEN)Maintenance:$(NC)"
	@echo "  make clean          - Remove backup files and caches"
	@echo ""

## install: Install/update dotfiles
install:
	@echo "$(BLUE)Installing dotfiles...$(NC)"
	./install
	@echo "$(GREEN)✓ Dotfiles installed successfully$(NC)"

## update: Pull latest changes and reinstall
update:
	@echo "$(BLUE)Updating dotfiles...$(NC)"
	git pull origin main
	./install
	@echo "$(GREEN)✓ Dotfiles updated successfully$(NC)"

## brew-install: Install all Homebrew packages from Brewfile
brew-install:
	@echo "$(BLUE)Installing Homebrew packages...$(NC)"
	@if command -v brew >/dev/null 2>&1; then \
		brew bundle --file="$(PWD)/Brewfile"; \
		echo "$(GREEN)✓ Homebrew packages installed$(NC)"; \
	else \
		echo "$(RED)✗ Homebrew not installed$(NC)"; \
		echo "Install it from: https://brew.sh"; \
		exit 1; \
	fi

## brew-check: Check which packages are missing
brew-check:
	@echo "$(BLUE)Checking Brewfile...$(NC)"
	@if command -v brew >/dev/null 2>&1; then \
		brew bundle check --file="$(PWD)/Brewfile" || true; \
	else \
		echo "$(RED)✗ Homebrew not installed$(NC)"; \
		exit 1; \
	fi

## brew-update: Update Brewfile with currently installed packages
brew-update:
	@echo "$(BLUE)Updating Brewfile...$(NC)"
	@if command -v brew >/dev/null 2>&1; then \
		brew bundle dump --force --file="$(PWD)/Brewfile"; \
		echo "$(GREEN)✓ Brewfile updated$(NC)"; \
		echo "$(YELLOW)Don't forget to commit the changes!$(NC)"; \
	else \
		echo "$(RED)✗ Homebrew not installed$(NC)"; \
		exit 1; \
	fi

## brew-cleanup: Remove packages not in Brewfile
brew-cleanup:
	@echo "$(YELLOW)⚠ This will uninstall packages not in Brewfile$(NC)"
	@read -p "Continue? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		echo "$(BLUE)Cleaning up packages...$(NC)"; \
		brew bundle cleanup --file="$(PWD)/Brewfile"; \
		echo "$(GREEN)✓ Cleanup completed$(NC)"; \
	else \
		echo "$(YELLOW)Cleanup cancelled$(NC)"; \
	fi

## git-status: Show git status
git-status:
	@echo "$(BLUE)Git status:$(NC)"
	@git status

## git-push: Push all commits to origin
git-push:
	@echo "$(BLUE)Pushing to origin...$(NC)"
	git push origin main
	@echo "$(GREEN)✓ Pushed successfully$(NC)"

## clean: Remove backup files and caches
clean:
	@echo "$(BLUE)Cleaning up...$(NC)"
	@rm -f .zshrc.backup
	@rm -f Brewfile.lock.json
	@echo "$(GREEN)✓ Cleanup completed$(NC)"

## claude-check: Verify Claude Code installation and configuration
claude-check:
	@echo "$(BLUE)Checking Claude Code installation...$(NC)"
	@if command -v claude >/dev/null 2>&1; then \
		echo "$(GREEN)✓ Claude Code CLI installed$(NC)"; \
		claude --version; \
		echo ""; \
		echo "$(BLUE)Checking configuration symlinks...$(NC)"; \
		test -L ~/.claude/CLAUDE.md && echo "$(GREEN)✓ CLAUDE.md symlink$(NC)" || echo "$(RED)✗ Missing CLAUDE.md symlink$(NC)"; \
		test -L ~/.claude/commands && echo "$(GREEN)✓ commands/ symlink$(NC)" || echo "$(RED)✗ Missing commands/ symlink$(NC)"; \
		test -L ~/.claude/settings.json && echo "$(GREEN)✓ settings.json symlink$(NC)" || echo "$(RED)✗ Missing settings.json symlink$(NC)"; \
		test -L ~/.claude/statusline.sh && echo "$(GREEN)✓ statusline.sh symlink$(NC)" || echo "$(RED)✗ Missing statusline.sh symlink$(NC)"; \
	else \
		echo "$(RED)✗ Claude Code not installed$(NC)"; \
		echo "Run './install' or 'curl -fsSL https://claude.ai/install.sh | bash'"; \
		exit 1; \
	fi

# Default target
.DEFAULT_GOAL := help
