# Aliases

# General
alias c="clear"
alias vim='nvim'

# System monitoring
alias temp='/usr/bin/vcgencmd measure_temp'

# lsd (modern ls replacement)
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# System update (macOS + Homebrew + npm + gems)
alias update='sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup; npm install npm -g; npm update -g; sudo gem update'
