# asdf
export ASDF_DATA_DIR="$HOME/.asdf"
if [[ -d "$ASDF_DATA_DIR" ]]; then
  source "$ASDF_DATA_DIR/asdf.sh"
  fpath=(${ASDF_DIR}/completions $fpath)
fi
