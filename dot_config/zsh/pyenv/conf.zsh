# vim: ft=zsh :
# shellcheck shell=bash

(( $+commands[pyenv] )) || return

eval "$(pyenv init -)"
