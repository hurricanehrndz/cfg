# vim:set ft=zsh :
#
(( $+commands[yarn] )) || return

yarn_bin_path=$(yarn global bin)

if [[ ! ${path[(Ie)$yarn_bin_path]} ]]; then
  path=("$yarn_bin_path" path)
fi
