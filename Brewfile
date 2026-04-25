# ========================================
# Homebrew Package Management
# ========================================
# This Brewfile defines all Homebrew packages installed on this system.
#
# Usage:
#   brew bundle                    # Install all packages
#   brew bundle check              # Check what's missing
#   brew bundle dump --force       # Update this file

# ========================================
# Custom Taps
# ========================================
tap "adembc/tap"
tap "oven-sh/bun"
tap "hashicorp/tap"
tap "raine/workmux"
tap "kacper/casks", "#{Dir.home}/.dotfiles/homebrew-casks"

# ========================================
# Development Tools
# ========================================

# Programming Languages & Runtimes
brew "bun"                          # Fast JavaScript runtime & toolkit
brew "go"                           # Go programming language
brew "node"                         # Node.js JavaScript runtime
brew "nvm"                          # Node Version Manager
brew "php"                          # PHP scripting language
brew "python3"                      # Python (latest stable)
brew "uv"                           # Fast Python package installer
brew "angular-cli"                  # CLI tool for Angular

# ========================================
# DevOps & Cloud Tools
# ========================================
brew "argocd"                       # GitOps continuous delivery for Kubernetes
brew "docker"                       # Container platform
brew "helm"                         # Kubernetes package manager
brew "k9s"                          # Kubernetes CLI management tool
brew "kubectx"                      # Switch between Kubernetes contexts and namespaces
brew "kubernetes-cli"               # kubectl command line tool
brew "sentry-cli"                   # Sentry command line client
brew "caddy"                        # Fast, multi-platform web server with automatic HTTPS
brew "hashicorp/tap/vault"          # HashiCorp Vault CLI - secrets management

# ========================================
# CLI Utilities
# ========================================
brew "bat"                          # Cat clone with syntax highlighting
brew "ccusage"                      # Claude Code usage tracking
brew "csvlens"                      # Command-line csv viewer
brew "curl"                         # Get a file from HTTP/HTTPS/FTP server
brew "diff-so-fancy"                # Good-lookin' diffs
brew "fd"                           # Simple, fast alternative to find
brew "fzf"                          # Fuzzy finder
brew "lsd"                          # Modern ls with colors and icons
brew "ripgrep"                      # Fast grep alternative (rg)
brew "yq"                           # YAML processor
brew "tree"                         # Display directories as trees
brew "visidata"                     # Terminal spreadsheet multitool
brew "googleworkspace-cli"          # Google Workspace CLI (Gmail, Drive, Calendar, etc.)
cask "google-cloud-sdk"             # Google Cloud SDK (gcloud CLI)

# ========================================
# Shell & Terminal
# ========================================
brew "tmux"                         # Terminal multiplexer
brew "raine/workmux/workmux"        # Orchestrate git worktrees and tmux windows for parallel Claude Code agents
brew "zoxide"                       # Smarter cd command

# ========================================
# Text Editors
# ========================================
brew "neovim"                       # Vim-based text editor

# ========================================
# Version Control
# ========================================
brew "git"                          # Distributed version control system

# ========================================
# Security Tools
# ========================================
brew "nmap"                         # Network scanner

# ========================================
# Network & VPN Tools
# ========================================
brew "openfortivpn"                 # FortiVPN client

# ========================================
# System Monitoring
# ========================================
brew "glances"                      # System monitoring tool
brew "htop"                         # Interactive process viewer
brew "tmux-mem-cpu-load"            # CPU/RAM status for tmux

# ========================================
# SSH Management
# ========================================
brew "adembc/tap/lazyssh"           # SSH connection manager

# ========================================
# Applications (Casks)
# ========================================

# Terminal
cask "alacritty"                    # GPU-accelerated terminal emulator
cask "ghostty"                      # Fast, native terminal emulator

# Development
cask "bambu-studio"                 # 3D model slicing software for Bambu Lab printers
cask "blender"                      # 3D creation suite
cask "docker-desktop"               # Docker Desktop for Mac
cask "webstorm"                     # JavaScript and TypeScript IDE
cask "zed"                          # High-performance Rust-based code editor

# Productivity
cask "raycast"                      # Control your tools with keystrokes
cask "google-chrome"                # Google Chrome web browser

# Communication
cask "discord"                      # Voice and text chat software
cask "telegram"                     # Cloud-based instant messaging
cask "whatsapp"                     # Messaging app

# Utilities
cask "insta360-link-controller"     # Insta360 Link webcam controller
cask "keymapp"                      # ZSA keyboard configuration tool
cask "betterdisplay"                # Display management and resolution control
cask "monitorcontrol"               # Control external monitor brightness
cask "rectangle"                    # Window management with keyboard shortcuts

# Printers
#cask "samsung-printer-driver"       # Samsung Universal Print Driver (C410, C43x, M2020)

# Office
cask "libreoffice"                  # Free office suite

# Fonts
cask "font-hack-nerd-font"          # Hack Nerd Font
cask "font-jetbrains-mono-nerd-font" # JetBrains Mono Nerd Font
cask "font-meslo-lg-nerd-font"      # Meslo LG Nerd Font

# Entertainment
cask "spotify"                      # Music streaming service
cask "vlc"                          # Free and open source media player

# ========================================
# Go Packages
# ========================================
go "golang.org/x/tools/gopls"      # Go language server
go "github.com/wailsapp/wails/v2/cmd/wails"  # Wails build tool
