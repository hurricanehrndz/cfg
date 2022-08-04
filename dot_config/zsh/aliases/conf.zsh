# Aliases

# exa
alias                                                   \
  l='exa -lh --group-directories-first -F --icons'      \
  la='exa -aalhF --group-directories-first --icons'     \
  lt='exa --tree --icons -d -a --ignore-glob "**/.git"'

# Git
alias g='git'
# Git add
alias ga='git add' \
      gaa='git add --all'
# Git commit
alias gc='git commit --verbose'                \
      gcs='git commit --verbose --sign'        \
      gca='git commit --verbose --amend'       \
      gcaa='git commit --verbose --amend --all'

alias gd='git diff' \
      gdc='git diff --cached'

alias gco='git checkout' \
      gcm='git checkout master'

alias gst='git status' \
      gss='git status --short'

alias grh='git reset' \
      grhh='git reset --hard'

alias gf='git fetch'   \
      gfm='git pull'    # a pull, is a fetch and merge

alias gp='git push'                     \
      gpF='git push --force'            \
      gpf='git push --force-with-lease' \
      gpc='git push --set-upstream origin HEAD'

# git clone
alias gcl='git clone --recursive-submodules'

# Git rebase sign commits
alias grsc='git rebase --exec "git --amend --no-edit -n -S" -i'

# git log
_git_log_oneline_format='%C(green)%h%C(reset) %s%C(red)%d %C(reset)%C(blue)Sig:%G?%C(reset)%n'
_git_log_brief_format='%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n'

_git_log_medium_format='%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n'
_git_log_medium_format+='%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n'
_git_log_medium_format+='%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
alias gl='git log --topo-order --pretty=format:"$_git_log_medium_format"' \
      glb='git log --topo-order --pretty=format:"$_git_log_brief_format"' \
      glg='git log --topo-order --all --graph --pretty=format:"${_git_log_oneline_format}"'


# quick cd
alias ".."="cd .." \
      "..."="cd ../.." \
      "...."="cd ../../.." \
      "....."="cd ../../../.."

# grep
alias grep="rg"

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

alias tm='tmux new-session -A -s main -e TMUX_SESSION_NAME=main'
alias vimdiff='nvim -d'

alias rg='rg -i -L'

alias iscp='scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias issh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias ssh='TERM=xterm-256color ssh'
function sshf() {
  local args uid
  args=("$@")
  if [[ "${args[1]}" =~ [0-9]+ ]]; then
    uid="${args[1]}"
    args=("${args[@]:1}")
  else
    uid=1000
  fi
  ssh -R /run/user/$uid/gnupg/S.gpg-agent:$(gpgconf --list-dirs agent-extra-socket) -A "$args[@]"
}
