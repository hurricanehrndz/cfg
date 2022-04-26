# vim:set ft=zsh sw=2 sts=2 ts=2 et:

# Time format
export TIME="\t%e real,\t%U user,\t%S sys"

# grc
if [[ "$OS_NAME" == "Darwin" ]]; then
  [[ -s "$HOMEBREW_PREFIX/etc/grc.zsh" ]] && source "$HOMEBREW_PREFIX/etc/grc.zsh"
else
  [[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh
fi
unset -f diff

# Pagers
# less: do not pollute home
export LESSHISTFILE="-"
export PAGER="less"
# less options
export LESS='-F -g -i -M -R -S -w -X -z-5 -j12'
if [[ -n "$(command -v bat)" ]]; then
  alias cat='bat'
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export BAT_THEME="TwoDark"
  export BAT_PAGER="less -RFI"
fi
