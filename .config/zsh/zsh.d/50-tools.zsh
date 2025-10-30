# External Tools Integration

# FZF (Fuzzy Finder) - Homebrew installation
if [[ -d /opt/homebrew/opt/fzf ]]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

# Zoxide (smarter cd)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi
