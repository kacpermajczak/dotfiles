# ~/.config/zsh/.zshrc
# Modular Zsh Configuration
# Each module in zsh.d/ handles a specific aspect of shell configuration

# Get the directory where this .zshrc file lives
ZDOTDIR="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"

# Load all configuration modules in order
# Modules are numbered to control load order:
# 00-* : PATH and core setup
# 10-* : Environment variables
# 20-* : Aliases
# 30-* : Functions
# 40-* : Plugins and frameworks
# 50-* : External tools
# 60-* : Shell options (history, completion, etc.)
# 99-* : Local machine-specific overrides (gitignored)

if [[ -d "$ZDOTDIR/zsh.d" ]]; then
  for config_file in "$ZDOTDIR/zsh.d"/*.zsh(N); do
    source "$config_file"
  done
  unset config_file
fi
