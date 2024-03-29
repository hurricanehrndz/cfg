#!/usr/bin/env bash

if [[ "$(uname -m)" == "arm64" ]]; then
  BREW_BIN="/opt/homebrew/bin/brew"
else
  BREW_BIN="/usr/local/bin/brew"
fi

if [[ ! -f "$BREW_BIN" ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -z "$BREW_PREFIX" ]]; then
  eval "$($BREW_BIN shellenv bash)"
fi

export GNUPGHOME="$HOME/.config/gnupg/"
if [[ ! -d $GNUPGHOME ]]; then
  mkdir -p "$GNUPGHOME"
  chmod 0700 "$GNUPGHOME"
fi

brew_update_flag_path="$HOME/.local/share/hrndz/.update"
mkdir -p "${brew_update_flag_path%/*}"
touch "$brew_update_flag_path"

# Setup gpg
KEYS=(
  "21D77144BCC519FD64EAA2C0919DA52AC863D46D"
  "C68DA2648035BCCE55710E3E0D2565B7C6058A69"
)
for key in "${KEYS[@]}"; do
  gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "$key"
  echo "$key:6:" | gpg --import-ownertrust
done
gpg --card-status &> /dev/null
gpg --list-secret-keys &> /dev/null

# Run chezmoi
if [[ ! -d  "$HOME/.local/share/chezmoi" ]]; then
  git clone \
    https://github.com/hurricanehrndz/cfg.git \
    "$HOME/.local/share/chezmoi"
fi
pushd "$HOME/.local/share/chezmoi" || exit
git pull
git-crypt unlock
popd || exit
chezmoi apply

# load services
gpgconf --kill gpg-agent
if launchctl print gui/$UID/homebrew.gpg.gpg-agent > /dev/null 2>&1 ; then
  launchctl bootout gui/$UID/homebrew.gpg.gpg-agent
  sleep 3
fi
launchctl bootstrap \
  gui/$UID \
  "$HOME/Library/LaunchAgents/homebrew.gpg.gpg-agent.plist"


if launchctl print gui/$UID/link-ssh-auth-sock > /dev/null 2>&1 ; then
  launchctl bootout gui/$UID/link-ssh-auth-sock
  sleep 3
fi
launchctl bootstrap \
  gui/$UID \
  "$HOME/Library/LaunchAgents/link-ssh-auth-sock.plist"
