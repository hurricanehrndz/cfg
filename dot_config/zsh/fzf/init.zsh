# vim: ft=zsh :

(( $+commands[fzf] )) || return


export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

fman() {
  man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
}

# if fd is avaible change default find command
(( $+commands[fd] )) || return

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
