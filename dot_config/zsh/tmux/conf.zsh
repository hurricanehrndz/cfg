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
