# vim: ft=zsh :

# Default editor (will set zsh binds to vi mode)
if [[ -n "$(command -v nvim)" ]]; then
  export EDITOR="nvim"
  export VISUAL="nvim"
  export CMP_ZSH_CACHE_DIR="$HOME/.cache/cmp/zsh"
  alias vi='nvim'
else
  export EDITOR="vi"
  export VISUAL="vi"
fi
