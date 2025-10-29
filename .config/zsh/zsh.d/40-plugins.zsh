# Oh-My-Zsh Configuration

# Theme
ZSH_THEME="robbyrussell"

# Plugins
# Core functionality
plugins=(git docker colorize cp)

# History enhancements
plugins+=(history history-substring-search)

# Command-line tools
plugins+=(httpie terraform fzf)

# Shell enhancements
plugins+=(alias-tips zsh-completions zsh-autosuggestions)
plugins+=(zsh-syntax-highlighting you-should-use zsh-bat)

# Load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# SSH completion
# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
