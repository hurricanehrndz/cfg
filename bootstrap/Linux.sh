#!/usr/bin/env bash
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
PATH=$XDG_BIN_HOME:$PATH
CHEZMOI_DIR="$XDG_DATA_HOME/chezmoi"

cargo_crates=(
  ripgrep
  tealdeer
)

build_from_source=(
  neovim
  tmux
)

eget_pkgs=(
  "dandavison/delta"
  "bootandy/dust"
  "ClementTsang/bottom"
  "Peltoche/lsd"
  "ajeetdsouza/zoxide"
  "jesseduffield/lazygit"
  "junegunn/fzf"
  "neovim/neovim"
  "sharkdp/bat"
  "sharkdp/fd"
  "sharkdp/hyperfine"
  "starship/starship"
  "twpayne/chezmoi"
  "neovim/neovim"
)

function check_privileges() {
  sudo_response=$(SUDO_ASKPASS=/bin/false sudo -A whoami 2>&1 | wc -l)
  if [[ $sudo_response = 2 ]]; then
    can_sudo=1
  elif [[ $sudo_response = 1 ]]; then
    can_sudo=0
  else
    echo "Unexpected sudo response: $sudo_response" >&2
    exit 1
  fi
}

function install_eget_pkg_manager() {
cat <<EOF > ~/.eget.toml
[global]
  quiet = false
  show_hash = false
  upgrade_only = true
  target = "~/.local/bin"

["dandavison/delta"]
  asset_filters = [ "linux", ".tar.gz", "^musl" ]

["bootandy/dust"]
  asset_filters = [ "linux", ".tar.gz", "^musl" ]

["ClementTsang/bottom"]
  asset_filters = [ "linux", ".tar.gz" ]

["Peltoche/lsd"]
  asset_filters = [ "linux", ".tar.gz" ]

["ajeetdsouza/zoxide"]
  asset_filters = [ "linux", ".tar.gz" ]

["jesseduffield/lazygit"]
  asset_filters = [ "linux", ".tar.gz" ]

["junegunn/fzf"]
  asset_filters = [ "linux", ".tar.gz" ]

["neovim/neovim"]
  asset_filters = [ "linux", ".tar.gz" ]

["sharkdp/bat"]
  asset_filters = [ "linux", ".tar.gz" ]

["sharkdp/fd"]
  asset_filters = [ "linux", ".tar.gz" ]

["sharkdp/hyperfine"]
  asset_filters = [ "linux", ".tar.gz" ]

["starship/starship"]
  asset_filters = [ "linux", ".tar.gz" ]

["twpayne/chezmoi"]
  asset_filters = [ "linux", ".tar.gz" ]
EOF
  if [[ ! -e "$XDG_BIN_HOME/eget" ]]; then
    echo "Installing eget pkg manager..."
    pushd "$XDG_BIN_HOME" || exit
    curl -o eget.sh https://zyedidia.github.io/eget.sh
    bash eget.sh >&/dev/null
    rm eget.sh
    popd || exit
  fi
}

function install_system_dependecies() {
  if [[ $can_sudo ]]; then
    echo "Installing system deps..."
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get -yq install zsh tmux build-essential cargo podman podman-docker
  fi
}

function install_cargo_crates() {
  for crate in "${cargo_crates[@]}"; do
    cargo install "${crate}"
  done
}

function install_eget_pkgs() {
  for pkg in "${eget_pkgs[@]}"; do
    echo "Installing ${pkg}..."
    eget "${pkg}"
  done
}

function clone_dotfiles() {
  if [[ ! -d "$CHEZMOI_DIR" ]]; then
    git clone https://github.com/hurricanehrndz/cfg.git "$CHEZMOI_DIR"
  fi
}

function install_from_source() {
  for pkg in "${build_from_source[@]}"; do
    docker run \
      -v "$HOME":"$HOME" \
      -e HOST_HOME="$HOME" ubuntu:latest \
      "$CHEZMOI_DIR/bootstrap/Linux/${pkg}/build.sh"
  done
}

function check_for_prerequisite() {
  required_binaries=(cargo)
  for binary in "${required_binaries[@]}"; do
    "Checking for exitence of $binary"
    if ! type -a "$binary" &>/dev/null; then
      echo "Missing pre-requisites.."
      exit 1
    fi
  done
}


###  Main ###
check_privileges
install_eget_pkg_manager
install_system_dependecies
clone_dotfiles
check_for_prerequisite
install_from_source
install_eget_pkgs
