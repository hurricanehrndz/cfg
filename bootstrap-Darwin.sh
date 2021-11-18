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
chezmoi init --exclude=encrypted --apply hurricanehrndz
chezmoi apply

# load services
gpgconf --kill gpg-agent
if launchctl print gui/$UID/homebrew.gpg.gpg-agent > /dev/null 2>&1 ; then
  launchctl bootout gui/$UID/homebrew.gpg.gpg-agent
  sleep 3
fi
launchctl bootstrap gui/$UID $HOME/Library/LaunchAgents/homebrew.gpg.gpg-agent.plist


if launchctl print gui/$UID/link-ssh-auth-sock > /dev/null 2>&1 ; then
  launchctl bootout gui/$UID/link-ssh-auth-sock
  sleep 3
fi
launchctl bootstrap gui/$UID $HOME/Library/LaunchAgents/link-ssh-auth-sock.plist
