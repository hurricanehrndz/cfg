# vim: ft=zsh :
# shellcheck shell=bash

# nvim inside tmux popup
function tvi () {
  if [[ -S $NVIM_LISTEN_ADDRESS ]]; then
    nvim_cmd="nvr -s --servername "$NVIM_LISTEN_ADDRESS""
    tmux detach
    tmux run-shell -t main "$nvim_cmd $@"
  else
    tmux display-message "nvim not running in parent!"
  fi
}

# Update environment before execute
function import_tmux_env() {
  if [[ -n "$TMUX" ]]; then
    ssh_auth_sock=$(tmux show-environment | grep "^SSH_AUTH_SOCK")
    [[ -n "$ssh_auth_sock" ]] && export $ssh_auth_sock
    display=$(tmux show-environment | grep  "^DISPLAY")
    [[ -n "$display" ]] && export $display
    nvim_listen_address=$(tmux show-environment | grep  "^NVIM_LISTEN_ADDRESS")
    [[ -n "$nvim_listen_address" ]] && export $nvim_listen_address
  fi
}
preexec_functions+=(import_tmux_env)

if [[ -n "$TMUX" ]]; then
  tmux_session="$(tmux display-message -p -F "#{session_name}")"
  tmux set-environment -t $tmux_session PATH "${(j.:.)path}"
  if [[ ! "$tmux_session" =~ "popup" ]]; then
    WINDOW_ID=$(tmux display -p "#{window_id}")
    export NVIM_LISTEN_ADDRESS="/tmp/nvim_${USER}_${WINDOW_ID}"
  fi
  # special zfunction to open vim in parent window
  if [[ "$tmux_session" =~ "popup" ]]; then
    export EDITOR='tvi'
    alias nvim='tvi'
    alias vi='tvi'
  fi
fi
