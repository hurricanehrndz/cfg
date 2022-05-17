# asdf
export ASDF_DATA_DIR=${XDG_DATA_HOME}/asdf
if [[ -d "$ASDF_DATA_DIR" ]]; then
  path=(${ASDF_DATA_DIR}/bin $path)
  source "${ASDF_DATA_DIR}/lib/asdf.sh"
  fpath=(${ASDF_DATA_DIR}/completions $fpath)
  direnv_versions=($HOME/.local/share/asdf/installs/direnv/*)
  latest_direnv_version="${direnv_versions[${#direnv_versions}]}"
  path=("$latest_direnv_version/bin" $path)

  # Hook direnv into your shell.
  eval "$(direnv hook zsh)"
fi
