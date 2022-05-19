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

# Define an init function and append to zvm_after_init_commands
function zvm_after_init() {
  if [[ "$OS_NAME" == "Darwin" ]]; then
    source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
  else
    source /usr/share/fzf/shell/key-bindings.zsh
  fi

  # my key bindings
  bindkey   -M   viins   '\C-X\C-S'      prepend_sudo
  bindkey   -M   viins   '\C-Y'          autosuggest-accept
  bindkey   -M   viins   '\C-K'          history-substring-search-up
  bindkey   -M   viins   '\C-J'          history-substring-search-down
  bindkey   -M   vicmd   'k'             history-substring-search-up
  bindkey   -M   vicmd   'j'             history-substring-search-down
  bindkey   -M   vicmd   '\C-X\C-E'      edit-command-line
  bindkey   -M   viins   '\C-X\C-E'      edit-command-line
}

function import-history() {
  fc -P
  fc -p $HISTFILE
}

ZVM_CURSOR_STYLE_ENABLED=false
