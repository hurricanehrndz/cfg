# Aliases

# exa
alias                                                   \
  l='exa -lh --group-directories-first -F --icons'      \
  la='exa -aalhF --group-directories-first --icons'     \
  lt='exa --tree --icons -d -a --ignore-glob "**/.git"'

# Git sign commits
alias gsoc='git rebase --exec "git --amend --no-edit -n -S" -i'

# quick cd
alias ".."="cd .." \
      "..."="cd ../.." \
      "...."="cd ../../.." \
      "....."="cd ../../../.."

# grep
alias grep="rg" \
      gi="grep -i"

# sudo
alias s="sudo -E" \
      si="sudo -i" \
      se="sudoedit"

# General aliases
alias top="btm"
alias cat='bat'
alias type='type -a'
alias mkdir='mkdir -p'
alias cm='chezmoi'

alias tm='tmux new-session -A -s main'
alias vimdiff='nvim -d'

alias rg='rg -i -L'

alias iscp='scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias issh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
