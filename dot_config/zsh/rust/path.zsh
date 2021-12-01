# vim:set ft=zsh :
export RUSTUP_HOME="$HOME/.local/share/rustup"
export CARGO_HOME="$HOME/.local/share/cargo"
export CARGO_BIN="$CARGO_HOME/bin"

if [[ -d "$CARGO_BIN" ]]; then
  path=("$CARGO_BIN" $path)
fi
