# vim: ft=zsh :

(( $+commands[fzf] )) || return

source $HOME/.config/zsh/plugins/fzf/shell/completion.zsh
source $HOME/.config/zsh/plugins/fzf/shell/key-bindings.zsh
