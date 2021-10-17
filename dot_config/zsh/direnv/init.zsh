# vim:set ft=zsh :

if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi
