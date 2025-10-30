# PATH Management
# Consolidated PATH configuration with automatic deduplication

# Initialize Homebrew environment
if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Remove duplicates from PATH
typeset -U PATH path

# Add directories to PATH in priority order
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "/opt/homebrew/opt/libpq/bin"
  "/usr/local/bin"
  $path
)

export PATH
