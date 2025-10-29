# ~/.zprofile
# Bootstrap file for XDG Base Directory compliant Zsh configuration

# Set ZDOTDIR to XDG-compliant location
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Source .zshrc from ZDOTDIR if it exists
if [[ -f "$ZDOTDIR/.zshrc" ]]; then
  source "$ZDOTDIR/.zshrc"
fi
