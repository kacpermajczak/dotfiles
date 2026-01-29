#!/bin/bash
set -e

DOTFILES_DIR="$HOME/.dotfiles"

init_homebrew_tap() {
  local tap_dir="$DOTFILES_DIR/homebrew-casks"
  [ -d "$tap_dir/.git" ] && return
  [ ! -d "$tap_dir" ] && return

  echo "Initializing local Homebrew tap..."
  cd "$tap_dir"
  git init -q && git add . && git commit -q -m "Local Homebrew casks"
  echo "✓ Local Homebrew tap initialized"
}

install_homebrew_packages() {
  command -v brew >/dev/null 2>&1 || { echo "Homebrew not installed"; return; }

  echo "Installing Homebrew packages..."
  brew bundle --file="$DOTFILES_DIR/Brewfile" || echo "⚠ Some Homebrew packages failed to install"

  if command -v claude >/dev/null 2>&1; then
    echo "✓ Claude Code installed"
  else
    echo "⚠️ Claude Code not found in PATH"
  fi
}

install_ohmyzsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
  echo "✓ Oh-My-Zsh installed"
}

install_zsh_plugins() {
  local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  local config_file="$DOTFILES_DIR/config/zsh-plugins.yaml"

  [ ! -f "$config_file" ] && { echo "⚠ $config_file not found, skipping zsh plugins"; return; }
  command -v yq >/dev/null 2>&1 || { echo "⚠ yq not installed, skipping zsh plugins"; return; }

  yq -r '.plugins | to_entries[] | "\(.key) \(.value)"' "$config_file" | while read -r name url; do
    [ ! -d "$zsh_custom/plugins/$name" ] && git clone -q "$url" "$zsh_custom/plugins/$name"
    echo "✓ $name installed"
  done
}

init_homebrew_tap
install_homebrew_packages
install_ohmyzsh
install_zsh_plugins
