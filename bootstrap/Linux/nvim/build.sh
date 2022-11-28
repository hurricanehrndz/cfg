#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export HOME="$HOST_HOME"

apt-get update
apt-get install -y \
  git \
  ninja-build \
  gettext \
  libtool \
  libtool-bin \
  autoconf \
  automake \
  cmake \
  g++ \
  pkg-config \
  unzip \
  curl \
  doxygen

mkdir -p /tmp/src
git clone https://github.com/neovim/neovim /tmp/src/neovim

cd /tmp/src/neovim || exit
git checkout nightly
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX="$HOST_HOME/.local"
make CMAKE_INSTALL_PREFIX="$HOME/.local" install
