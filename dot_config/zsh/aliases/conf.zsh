# Aliases

# exa
alias                                                   \
  l='exa -lh --group-directories-first -F --icons'      \
  la='exa -aalhF --group-directories-first --icons'     \
  lt='exa --tree --icons -d -a --ignore-glob "**/.git"'

# Git
alias g='git'
alias ga='git add'
alias gc='git commit --verbose'              \
      gcs='git commit -S --verbose'          \
      gca='git commit -a --verbose'          \
      gca!='git commit -a --verbose --amend'

alias gd='git diff' \
      gdc='git diff --cached'

alias gco='git checkout' \
      gcm='git checkout master'

alias gst='git status' \
      gss='git status --short'

alias grh='git reset' \
      grhh='git reset --hard'

alias gf='git fetch'                    \
      gfm='git pull'                    \
      gp='git push'                     \
      gpF='git push --force'            \
      gpf='git push --force-with-lease' \
      gpc='git push --set-upstream origin "$(git-branch-current 2> /dev/null)"'

# git log
_git_log_oneline_format='%C(green)%h%C(reset) %s%C(red)%d %C(reset)%C(blue)Sig:%G?%C(reset)%n'
_git_log_brief_format='%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n'

_git_log_medium_format='%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n'
_git_log_medium_format+='%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n'
_git_log_medium_format+='%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
alias gl='git log --topo-order --pretty=format:"$_git_log_medium_format"' \
      glb='git log --topo-order --pretty=format:"$_git_log_brief_format"' \
      glg='git log --topo-order --all --graph --pretty=format:"${_git_log_oneline_format}"'

alias gcl='git clone --recursive-submodules'
alias gsoc='git rebase --exec "git --amend --no-edit -n -S" -i'


# grep
alias grep='grep --color=auto'   \
      egrep='egrep --color=auto' \
      fgrep='fgrep --color=auto'

# General aliases
alias cat='bat'
alias type='type -a'
alias mkdir='mkdir -p'

alias tm='tmux new-session -A -s main'
alias vimdiff='nvim -d'

alias rg='rg -i -L'

alias iscp='scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias issh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
