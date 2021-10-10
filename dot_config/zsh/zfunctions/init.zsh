# init all personal zfunctions

load_my_zfunctions() {
  local pfunction

  # (-.N:t) <- is a qualifier, - work on target of symbolic link, . only plain files, N null glob (return empty)
  # :t is modifier equivalent to basename
  local _zfunction_glob='^(init.zsh|path.zsh|conf.zsh)(-.N:t)'
  # Extended globbing is needed for listing autoloadable function directories.
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  for pfunction in ${ZDOTDIR}/zfunctions/$~_zfunction_glob; do
    autoload -Uz "$pfunction"
  done
}

load_my_zfunctions
