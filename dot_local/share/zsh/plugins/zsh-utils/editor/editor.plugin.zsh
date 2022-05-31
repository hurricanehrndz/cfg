# /usr/bin/env zsh
# vim: ft=zsh :
# shellcheck shell=bash
#
# Inserts 'sudo ' at the beginning of the line.
function prepend_sudo {
  if [[ "$BUFFER" != su(do|)\ * ]]; then
    BUFFER="sudo $BUFFER"
    (( CURSOR += 5 ))
  fi
}
zle -N prepend_sudo

autoload -U edit-command-line
zle -N edit-command-line

bindkey -v

# my key bindings
bindkey   -M   viins   '\C-X\C-S'      prepend_sudo
bindkey   -M   vicmd   '\C-X\C-E'      edit-command-line
bindkey   -M   viins   '\C-X\C-E'      edit-command-line
bindkey   -M   viins   '^P'            history-search-backward
bindkey   -M   viins   '^N'            history-search-forward
