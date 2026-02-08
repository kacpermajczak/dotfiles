# Environment Variables

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

# Kubernetes
export KUBECONFIG="$HOME/.kube/config"

# Locale
export LANG=en_US.UTF-8
export LC_TIME=pl_PL.UTF-8

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
