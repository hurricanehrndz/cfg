# vim: ft=zsh :

(( $+commands[pyenv] )) || return

export PYENV_ROOT="$HOME/.local/share/pyenv"
path=("$PYENV_ROOT/shims" $path)
