# asdf
export ASDF_DATA_DIR="$HOME/.asdf"
if [[ -d "$ASDF_DATA_DIR" ]]; then
  path=(${ASDF_DATA_DIR}/bin $path)
  source "${ASDF_DATA_DIR}/lib/asdf.sh"
  fpath=(${ASDF_DATA_DIR}/completions $fpath)
  # Hook direnv into your shell.
  eval "$(asdf exec direnv hook zsh)"

  # A shortcut for asdf managed direnv.
  direnv() { asdf exec direnv "$@"; }
fi
