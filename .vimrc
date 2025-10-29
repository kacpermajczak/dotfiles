" ~/.vimrc
" XDG Base Directory wrapper for vim configuration
" This file ensures vim uses ~/.config/vim for configuration

" Set vim to use XDG-compliant config directory
set runtimepath^=~/.config/vim
set runtimepath+=~/.config/vim/after

" Source the actual vimrc from XDG location
if filereadable(expand('~/.config/vim/vimrc'))
  source ~/.config/vim/vimrc
endif
