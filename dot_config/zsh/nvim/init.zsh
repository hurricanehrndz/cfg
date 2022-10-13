# shellcheck shell=bash
# vim: ft=zsh :

function smart_editor() {
  if [[ $TMUX_POPUP -eq 1 ]] && [[ -S "$NVIM" ]]; then
    nvim_cmd="nvr -s"
    tmux detach
    tmux run-shell "$nvim_cmd $*"
  elif [[ -n "$NVIM" ]]; then
    nvr -s -l "$@"
  elif [[ $TMUX_POPUP -eq 1 ]]; then
    tmux display-message "nvim not running in parent!"
  else
    nvim --listen "$NVIM_SOCKET" "$@"
  fi
}

if [[ -z "$(command -v nvim)" ]]; then
  export EDITOR="vi"
  export VISUAL="vi"
  alias v='vi'
  return
fi

export CMP_ZSH_CACHE_DIR="$HOME/.cache/cmp/zsh"
if [[ -z "${TMUX}" ]]; then
  export EDITOR="nvim"
  export VISUAL="nvim"
  alias vi='nvim'
  alias v='nvim'
  return
fi

eval "$(tmux showenv -s TMUX_POPUP 2>/dev/null)"
eval "$(tmux showenv -s NVIM 2>/dev/null)" || true
if [[ -z "${TMUX_POPUP}" ]]; then
  TMUX_INFO="$(tmux display-message -p -F "#{window_id}.#{pid}.#{session_id}:#{session_name}")"
  TMUX_UNIQUE_ID="${TMUX_INFO%%:*}"
  TMUX_UNIQUE_ID="${TMUX_UNIQUE_ID//\$/}"
  NVIM_SOCKET="/tmp/nvim.${USER}/${TMUX_UNIQUE_ID}"
  export NVIM_SOCKET
fi

export EDITOR='smart_editor'
export VISUAL='nvr --remote-tab-silent'
alias vi='smart_editor'
alias v='smart_editor'
