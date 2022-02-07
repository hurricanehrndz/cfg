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

mkdir -p "$HOME/.config/chezmoi"
cat >| $HOME/.config/chezmoi/chezmoi.toml <<-EOF
encryption = "gpg"
[gpg]
  recipient = "21D77144BCC519FD64EAA2C0919DA52AC863D46D"
EOF

brew install --force chezmoi
brew_update_flag_path="$HOME/.local/share/hrndz/.update"
mkdir -p "${brew_update_flag_path%/*}"
touch "$brew_update_flag_path"
chezmoi init --apply hurricanehrndz

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
