
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/home/vcuum/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2750
SAVEHIST=2500
setopt autocd beep
bindkey '^R' history-incremental-search-backward
# End of lines configured by zsh-newuser-install

export LIBVA_DRIVER_NAME=radeonsi
export XDG_MENU_PREFIX=arch-

# Created by `pipx` on 2026-05-16 00:54:08
export PATH="$PATH:/home/vcuum/.local/bin"
