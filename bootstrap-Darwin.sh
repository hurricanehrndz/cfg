#!/bin/zsh
setopt extendedglob
BREW_BIN=( /(usr|opt)/(local|homebrew)/bin/brew(N) )

if [[ -z  "$BREW_BIN" ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  BREW_BIN=( /(usr|opt)/(local|homebrew)/bin/brew(N) )
fi

if [[ -z "$BREW_PREFIX" ]]; then
  eval "$($BREW_BIN shellenv zsh)"
fi

export GNUPGHOME="$HOME/.config/gnupg/"
mkdir -p $GNUPGHOME
chmod 0700 $GNUPGHOME

brew install --force chezmoi
chezmoi init --apply hurricanehrndz
