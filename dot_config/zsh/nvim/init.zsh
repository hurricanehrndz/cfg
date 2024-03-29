# shellcheck shell=bash
# vim: ft=zsh :

# Default editor (will set zsh binds to vi mode)
if [[ -n "$(command -v nvim)" ]]; then
  if [[ -n "${NVIM}" || -n "${NVIM_LISTEN_ADDRESS}" ]]; then
    export EDITOR="nvr -l"
    export VISUAL="nvr --remote-tab-silent"
    alias vi='nvr -l'
    alias v='nvr -l'
  else
    export EDITOR="nvim"
    export VISUAL="nvim"
    alias vi='nvim'
    alias v='nvim'
  fi
  export CMP_ZSH_CACHE_DIR="$HOME/.cache/cmp/zsh"
else
  export EDITOR="vi"
  export VISUAL="vi"
fi
