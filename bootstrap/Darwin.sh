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

$BREW_BIN install --force chezmoi git-crypt gnupg rcmdnk/file/brew-file
# activate brew-file
if [[ -f $(brew --prefix)/etc/brew-wrap ]];then
  source $(brew --prefix)/etc/brew-wrap
fi

brew_update_flag_path="$HOME/.local/share/hrndz/.update"
mkdir -p "${brew_update_flag_path%/*}"
touch "$brew_update_flag_path"

# Setup gpg
KEYS=("21D77144BCC519FD64EAA2C0919DA52AC863D46D" "C68DA2648035BCCE55710E3E0D2565B7C6058A69")
for key in ${KEYS[@]}; do
  gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "$key"
  echo "$key:6:" | gpg --import-ownertrust
  gpg --card-status
  gpg --list-secret-keys
done

# Run chezmoi
git clone https://github.com/hurricanehrndz/dotfiles.git "$HOME/.local/share/chezmoi"
pushd "$HOME/.local/share/chezmoi"
git-crypt unlock
popd
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
