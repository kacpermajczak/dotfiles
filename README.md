# Dotfiles

Personal dotfiles managed with [Dotbot](https://github.com/anishathalye/dotbot) following XDG Base Directory specification.

## Features

- ✨ **XDG Compliant** - All configs in `~/.config/`
- 🧩 **Modular Zsh** - Organized in `zsh.d/` for easy maintenance
- 📦 **Declarative Packages** - Homebrew packages in `Brewfile`
- 🔧 **Automated Setup** - One command installation with Dotbot
- 🎨 **Consistent Theme** - Catppuccin Mocha across all tools

## Quick Start

### Prerequisites

```bash
# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Installation

```bash
# Clone dotfiles
git clone https://github.com/kacpermajczak/dotfiles.git ~/.dotfiles

# Run installation
cd ~/.dotfiles
./install
```

This will:
1. Create symlinks for all configuration files
2. Install Homebrew packages from `Brewfile`
3. Initialize git submodules (Dotbot)

### Post-Installation

```bash
# Install Oh-My-Zsh (required for zsh config)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Oh-My-Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Restart shell
exec zsh
```

### Verify Installation

After installation, verify everything is working:

```bash
# Check Claude Code is installed
claude --version

# Check configuration symlinks
ls -la ~/.claude/

# Verify symlinks are created
test -L ~/.claude/CLAUDE.md && echo "✓ CLAUDE.md linked" || echo "✗ CLAUDE.md missing"
test -L ~/.claude/commands && echo "✓ commands/ linked" || echo "✗ commands/ missing"
test -L ~/.claude/settings.json && echo "✓ settings.json linked" || echo "✗ settings.json missing"
test -L ~/.claude/statusline.sh && echo "✓ statusline.sh linked" || echo "✗ statusline.sh missing"

# Test shell alias
cc --version
```

## Makefile Commands

For convenience, common operations are available via `make`:

```bash
# Show all available commands
make help

# Install/update dotfiles
make install

# Pull latest changes and reinstall
make update

# Install Homebrew packages
make brew-install

# Check what packages are missing
make brew-check

# Update Brewfile after installing new packages
make brew-update

# Remove packages not in Brewfile
make brew-cleanup

# Git operations
make git-status
make git-push

# Clean up backup files
make clean
```

**Most used commands:**
```bash
make install        # Setup dotfiles
make brew-check     # Check package status
make brew-update    # Update Brewfile after `brew install`
make update         # Update everything
```

## Structure

```
~/.dotfiles/
├── .config/
│   ├── alacritty/          # Alacritty terminal config
│   ├── claude/             # Claude Code AI assistant
│   │   ├── CLAUDE.md       # Universal programming principles
│   │   ├── settings.json   # Claude Code settings
│   │   ├── statusline.sh   # Custom statusline script
│   │   └── commands/       # Custom slash commands
│   ├── git/
│   │   ├── config          # Git configuration
│   │   └── ignore          # Global gitignore
│   ├── nvim/               # Neovim (LazyVim) config
│   ├── tmux/               # Tmux configuration
│   ├── vim/
│   │   ├── vimrc           # Vim configuration
│   │   └── ideavimrc       # IdeaVim configuration
│   └── zsh/
│       ├── .zshrc          # Zsh loader
│       └── zsh.d/          # Modular zsh config
│           ├── 00-path.zsh
│           ├── 10-exports.zsh
│           ├── 20-aliases.zsh
│           ├── 30-functions.zsh
│           ├── 40-plugins.zsh
│           ├── 50-tools.zsh
│           ├── 60-history.zsh
│           └── 99-local.zsh.example
├── Brewfile                # Homebrew packages
├── Makefile                # Simplified commands
├── README.md               # This file
├── .gitignore
├── .vimrc                  # Vim wrapper (XDG compatibility)
├── .zprofile               # Zsh bootstrap (sets ZDOTDIR)
├── dotbot/                 # Dotbot submodule
├── install*                # Installation script
└── install.conf.yaml       # Dotbot configuration
```

## Homebrew Package Management

All Homebrew packages are declaratively managed in `Brewfile`.

### Package Categories

- **Development Tools**: Go, Node.js, PHP, Python
- **DevOps/Cloud**: Docker, Kubernetes (kubectl, k9s, helm)
- **AI Tools**: Claude Code (Homebrew cask)
- **CLI Utilities**: bat, fzf, ripgrep, lsd, fd, tree, visidata, csvlens
- **Shell/Terminal**: tmux, neovim
- **Security**: nmap
- **Network**: openfortivpn (VPN), lazyssh (SSH manager)
- **Monitoring**: glances, htop
- **Applications**: Alacritty, Docker Desktop, Raycast, Discord, Spotify, LibreOffice

### Brewfile Commands

**Easy way (using Makefile):**
```bash
make brew-install    # Install all packages
make brew-check      # Check what's missing
make brew-update     # Update Brewfile
```

**Direct brew commands:**
```bash
# Install all packages
brew bundle --file=~/.dotfiles/Brewfile

# Check what's missing
brew bundle check --file=~/.dotfiles/Brewfile

# Update Brewfile after installing new packages
cd ~/.dotfiles
brew bundle dump --force
git add Brewfile
git commit -m "Update Brewfile"
```

## Configuration

### Machine-Specific Settings

Create `~/.config/zsh/zsh.d/99-local.zsh` for machine-specific configuration:

```bash
# Copy example file
cp ~/.config/zsh/zsh.d/99-local.zsh.example ~/.config/zsh/zsh.d/99-local.zsh

# Edit for this machine
vim ~/.config/zsh/zsh.d/99-local.zsh
```

This file is gitignored and won't be committed.

### Modular Zsh Configuration

Zsh configuration is split into numbered modules that load in order:

- `00-path.zsh` - PATH management with deduplication
- `10-exports.zsh` - Environment variables
- `20-aliases.zsh` - Command aliases
- `30-functions.zsh` - Custom functions (SSH fuzzy search)
- `40-plugins.zsh` - Oh-My-Zsh plugins
- `50-tools.zsh` - External tools (FZF, zoxide)
- `60-history.zsh` - Shell history configuration
- `99-local.zsh` - Machine-specific overrides (gitignored)

## Key Tools

### Terminal

- **Alacritty** - GPU-accelerated terminal
- **Tmux** - Terminal multiplexer

### Shell Enhancements

- **FZF** - Fuzzy finder (installed via Homebrew)
- **Zoxide** - Smarter cd command
- **lsd** - Modern ls with icons

### Editors

- **Neovim** - LazyVim configuration
- **Vim** - Classic vim with plugins

### Development

- **Git** - Version control with diff-so-fancy
- **Docker** - Containerization
- **Node.js** - JavaScript runtime with nvm

### AI Development

- **Claude Code** - AI-powered coding assistant
  - Global instructions: `~/.claude/CLAUDE.md` (universal programming principles)
  - Settings: `~/.claude/settings.json` (Claude Code configuration)
  - Custom statusline: `~/.claude/statusline.sh` (session tracking, git status, mood assistant)
  - Custom commands: `~/.claude/commands/` (slash commands)
  - Installed automatically via Homebrew (`brew install --cask claude-code`)
  - Shell alias: `cc` (shortcut for `claude`)

**Available Custom Commands:**
- `/astro-help` - Astro framework documentation help
- `/changelog` - Generate changelog from git tags
- `/commit-msg` - Automated SRP-compliant commit generation
- `/debug-sentry` - Sentry error analysis and debugging
- `/go` - Enhanced code generation with systematic approach
- `/seo-audit` - Comprehensive SEO and usability audit
- `/test-web` - Playwright E2E testing and browser automation

## Updating

### Update Dotfiles

```bash
cd ~/.dotfiles
git pull origin main
./install
```

### Update Homebrew Packages

```bash
brew update
brew upgrade
brew bundle check --file=~/.dotfiles/Brewfile
```

### Update Zsh Plugins

```bash
cd ~/.oh-my-zsh
git pull
```

## Troubleshooting

### Oh-My-Zsh Plugin Not Found

```bash
# Install missing plugins
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

### FZF Not Working

FZF is installed via Homebrew and sourced in `50-tools.zsh`. If it's not working:

```bash
brew install fzf
```

### Path Issues

Check PATH order in `00-path.zsh`. It uses `typeset -U` to automatically remove duplicates.

## License

MIT

## Credits

- [Dotbot](https://github.com/anishathalye/dotbot) - Dotfile management
- [Oh-My-Zsh](https://ohmyz.sh/) - Zsh framework
- [Catppuccin](https://github.com/catppuccin) - Color scheme
