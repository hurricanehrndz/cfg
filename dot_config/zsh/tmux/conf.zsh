# vim: ft=zsh :
# shellcheck shell=bash

# nvim inside tmux popup
function tvi () {
  eval "$(tmux show-environment -s NVIM_LISTEN_ADDRESS)"
  if [[ -S $NVIM_LISTEN_ADDRESS ]]; then
    nvim_cmd="nvr -s --servername "$NVIM_LISTEN_ADDRESS""
    tmux detach
    tmux run-shell -t main "$nvim_cmd $@"
  else
    tmux display-message "nvim not running in parent!"
  fi
}

function update_nvim_remote_socat() {
  if [[ "$TMUX_SESSION_NAME" == "main" ]]; then
    export NVIM_LISTEN_ADDRESS="/tmp/nvim_${USER}_${TMUX_PANE}"
  else
    # special zfunction to open vim in parent window
    export EDITOR='tvi'
    alias nvim='tvi'
    alias vi='tvi'
  fi
}

# if [[ -n "$TMUX" ]]; then
#   update_nvim_remote_socat
# fi
