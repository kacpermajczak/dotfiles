export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=( git docker aliases colorize cp )
plugins+=( history history-substring-search httpie sudo )
plugins+=( alias-tips zsh-completions zsh-autosuggestions )
plugins+=( zsh-syntax-highlighting )

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8


## ALIAS
alias c="clear"
alias temp='/usr/bin/vcgencmd measure_temp'

eval "$(zoxide init --cmd cd zsh)"

## GIT
GIT_AUTHOR_NAME="Kacper Majczak"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="kacpermajczak1@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

##### EXPORT

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
