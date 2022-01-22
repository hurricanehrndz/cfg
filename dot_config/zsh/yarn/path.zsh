# vim:set ft=zsh :
#
(( $+commands[yarn] )) || return

yarn_bin_path="$HOME/.yarn/bin"

path=("$yarn_bin_path" $path)
