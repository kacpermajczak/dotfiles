# External Tools Integration

# FZF (Fuzzy Finder) - Homebrew installation
if [[ -d /opt/homebrew/opt/fzf ]]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

# Zoxide (smarter cd)
eval "$(zoxide init --cmd cd zsh)"

# Starship (modern prompt)
eval "$(starship init zsh)"
