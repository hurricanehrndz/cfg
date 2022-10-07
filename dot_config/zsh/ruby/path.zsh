if [ -d "$HOMEBREW_PREFIX/opt/ruby/bin" ]; then
  export PATH="$HOMEBREW_PREFIX/opt/ruby/bin":$PATH
  export PATH="$(gem environment gemdir/bin)":$PATH
fi
