#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export HOME="$HOST_HOME"

apt-get update
apt-get install -y \
  git \
  build-essential \
  zlib1g \
  zlib1g-dev \
  libssl-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  wget \
  curl \
  llvm \
  libncurses5-dev \
  libncursesw5-dev \
  xz-utils \
  tk-dev \
  libffi-dev \
  liblzma-dev


export PYENV_ROOT="$HOME/.local/share/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if [[ ! -d "$PYENV_ROOT" ]]; then
  git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"
  pushd "$PYENV_ROOT" || exit
  src/configure
  make -C src
  popd || exit
fi

eval "$(pyenv init -)"
pyenv "$@"
