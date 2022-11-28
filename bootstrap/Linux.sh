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
OS_CODENAME="$(awk -F= '/VERSION_CODENAME/{print $2}' /etc/os-release)"
PYENV_ROOT="$HOME/.local/share/pyenv"
PYTHON_VERSION="3.10"

cargo_crates=(
  "ripgrep:rg"
  "tealdeer:tldr"
)

build_from_source=(
  nvim
  tmux
)

eget_pkgs=(
  "dandavison/delta:delta"
  "bootandy/dust:dust"
  "ClementTsang/bottom:btm"
  "Peltoche/lsd:lsd"
  "ajeetdsouza/zoxide:zoxide"
  "jesseduffield/lazygit:lazygit"
  "junegunn/fzf:fzf"
  "sharkdp/bat:bat"
  "sharkdp/fd:fd"
  "sharkdp/hyperfine:hyperfine"
  "starship/starship:starship"
  "twpayne/chezmoi:chezmoi"
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
  target = "$HOME/.local/bin"

["dandavison/delta"]
  asset_filters = [ "linux", ".tar.gz", "^musl" ]

["bootandy/dust"]
  asset_filters = [ "linux", ".tar.gz", "^musl" ]

["ClementTsang/bottom"]
  asset_filters = [ "linux", ".tar.gz" ]
  file = "btm"

["Peltoche/lsd"]
  asset_filters = [ "linux", ".tar.gz", "^musl" ]

["ajeetdsouza/zoxide"]
  asset_filters = [ "linux", ".tar.gz" ]

["jesseduffield/lazygit"]
  asset_filters = [ "Linux", ".tar.gz" ]

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
    if ! which podman; then
      sudo apt-get -yq install \
        npm \
        nodejs \
        zsh \
        tmux \
        build-essential \
        podman \
        podman-docker
      echo "Exiting, run newgrp lxd before running again!"
    fi
  fi
}

function install_cargo_crates() {
  for crate_info in "${cargo_crates[@]}"; do
    IFS=":"
    set -- $crate_info
    if [[ ! -f "${XDG_BIN_HOME}/${2}" ]]; then
      echo "Installing ${1}..."
      docker run --rm \
        -v "$HOME":"$HOME" \
        -e HOST_HOME="$HOME" docker.io/rust:latest \
        cargo install --root "$HOME/.local/" "${1}"
    fi
  done
}

function install_eget_pkgs() {
  for pkg_info in "${eget_pkgs[@]}"; do
    IFS=":"
    set -- $pkg_info
    if [[ ! -f "${XDG_BIN_HOME}/${2}" ]]; then
      echo "Installing ${pkg}..."
      eget "${1}"
    fi
  done
}

function clone_dotfiles() {
  if [[ ! -d "$CHEZMOI_DIR" ]]; then
    git clone https://github.com/hurricanehrndz/cfg.git "$CHEZMOI_DIR"
  fi
}

function install_from_source() {
  for pkg in "${build_from_source[@]}"; do
    [[ -f "${XDG_BIN_HOME}/${pkg}" ]] || docker run \
      --rm \
      -v "$HOME":"$HOME" \
      -e HOST_HOME="$HOME" ubuntu:"$OS_CODENAME" \
      "$CHEZMOI_DIR/bootstrap/Linux/${pkg}/build.sh"
  done
}

function install_python() {
  if ! ls "$PYENV_ROOT/versions/*" &>/dev/null; then
    docker run \
      --rm \
      -v "$HOME":"$HOME" \
      -e HOST_HOME="$HOME" ubuntu:"$OS_CODENAME" \
      "$CHEZMOI_DIR/bootstrap/Linux/python/build.sh" install $PYTHON_VERSION
  fi
}

function configure_gpg() {
  KEYS=("21D77144BCC519FD64EAA2C0919DA52AC863D46D" "C68DA2648035BCCE55710E3E0D2565B7C6058A69")
  for key in "${KEYS[@]}"; do
    gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "$key"
    echo "$key:6:" | gpg --import-ownertrust
  done
  gpg --card-status &> /dev/null
  gpg --list-secret-keys &> /dev/null
}


###  Main ###
check_privileges
install_eget_pkg_manager
install_system_dependecies
clone_dotfiles
install_cargo_crates
install_from_source
install_eget_pkgs
install_python
configure_gpg
