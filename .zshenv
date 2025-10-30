# ~/.zshenv
# This file is ALWAYS sourced first by zsh (before .zprofile, .zshrc, .zlogin)
# Set ZDOTDIR here so zsh knows where to find .zshrc

# Set ZDOTDIR to XDG-compliant location
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
