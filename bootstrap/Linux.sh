#!/usr/bin/zsh
# shellcheck shell=bash

XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"
XDG_CACHE_HOME="$HOME/.cache"
XDG_BIN_HOME="$HOME/.local/bin"
export XDG_DATA_HOME \
  XDG_CONFIG_HOME \
  XDG_CACHE_HOME \
  XDG_BIN_HOME


mkdir -p "$XDG_BIN_HOME"
# shellcheck disable=2206
path=($XDG_BIN_HOME $path)

# shellcheck disable=2154
if ! (( $+commands[eget] )); then
  pushd "$XDG_BIN_HOME" || exit
  curl -o eget.sh https://zyedidia.github.io/eget.sh
  bash eget.sh
  rm eget.sh
  popd || exit
fi

# Install must have packages
pushd "$XDG_BIN_HOME" || exit
./eget ogham/exa --asset musl
./eget starship/starship --asset musl
./eget BurntSushi/ripgrep --asset musl
./eget sharkdp/fd --asset musl
./eget sharkdp/bat --asset musl
./eget mjakob-gh/build-static-tmux --asset ^stripped
./eget dandavison/delta --asset musl
./eget jesseduffield/lazygit
./eget dbrgn/tealdeer --asset musl
./eget direnv/direnv
./eget ajeetdsouza/zoxide --asset musl
./eget twpayne/chezmoi --asset musl_amd64
./eget sharkdp/hyperfine --asset musl
./eget junegunn/fzf
rm tmux
# shellcheck disable=2035
mv *tmux tmux
popd || exit

if [[ ! -d "$XDG_BIN_HOME/zsh" ]]; then
  ZSH_INSTALL_SCRIPT="/run/user/$UID/zsh_install"
  curl -o "$ZSH_INSTALL_SCRIPT"  \
    -L  https://raw.githubusercontent.com/romkatv/zsh-bin/master/install
  chmod +x "$ZSH_INSTALL_SCRIPT"
  "$ZSH_INSTALL_SCRIPT" -d "$HOME/.local" -e no
  rm "$ZSH_INSTALL_SCRIPT"
fi
