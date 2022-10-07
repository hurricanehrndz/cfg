# shellcheck shell=bash
if [[ -d "$HOMEBREW_PREFIX/opt/ruby/bin" ]]; then
  export PATH="$HOMEBREW_PREFIX/opt/ruby/bin":$PATH
  GEM_PATH="$(gem environment gemdir)/bin"
  export PATH=$GEM_PATH:$PATH
fi
