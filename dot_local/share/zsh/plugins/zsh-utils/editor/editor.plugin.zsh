# /usr/bin/env zsh
# vim: ft=zsh :
# shellcheck shell=bash
#
# Esc-S to insert sudo in front of command
function prepend-sudo { # Insert "sudo " at the beginning of the line
  if [[ $BUFFER != "sudo "* ]]; then
    BUFFER="sudo $BUFFER"; CURSOR+=5
  fi
}
zle -N prepend-sudo

# Note: requires vi key bindings in zsh!
bindkey -M viins '^Xs' prepend-sudo
bindkey -M vicmd '^Xs' prepend-sudo

autoload -U edit-command-line
zle -N edit-command-line

bindkey -v

# my key bindings
bindkey   -M   vicmd   '^X^E'      edit-command-line
bindkey   -M   viins   '^X^E'      edit-command-line
bindkey   -M   viins   '^P'        history-search-backward
bindkey   -M   viins   '^N'        history-search-forward
