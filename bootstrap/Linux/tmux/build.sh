#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export HOME="$HOST_HOME"

apt-get update
apt-get install -y \
  git \
  automake \
  libevent-dev \
  ncurses-dev \
  build-essential \
  bison \
  pkg-config

mkdir -p /tmp/src
git clone https://github.com/tmux/tmux /tmp/src/tmux

cd /tmp/src/tmux || exit

tag="$(git tag -l --sort=refname  | tail -1)"
git checkout "$tag"
sh autogen.sh
./configure --prefix="$HOME/.local" --enable-static
make &&  make install
