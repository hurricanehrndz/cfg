# vim:set ft=zsh sw=2 sts=2 ts=2 et:

if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi
