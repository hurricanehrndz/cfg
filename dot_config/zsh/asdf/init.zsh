# asdf
export ASDF_DATA_DIR=${XDG_DATA_HOME}/asdf
if [[ -d "$ASDF_DATA_DIR" ]]; then
  path=(${ASDF_DATA_DIR}/bin $path)
  source "${ASDF_DATA_DIR}/lib/asdf.sh"
  fpath=(${ASDF_DATA_DIR}/completions $fpath)
fi
