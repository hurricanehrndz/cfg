# vim: ft=zsh :

(( $+commands[zoxide] )) || return

eval "$(zoxide init zsh)"
