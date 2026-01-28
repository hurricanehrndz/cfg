#!/usr/bin/env bash

set -e

echo "Starting bootstrap process..."

if ! command -v chezmoi &>/dev/null; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
else
    echo "chezmoi already installed"
fi

if ! command -v gh &>/dev/null; then
    echo "Installing gh..."
    mkdir -p "$HOME/.local/bin"
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    latest_gh_ver="$(curl -s https://api.github.com/repos/cli/cli/releases/latest | grep -oP '"tag_name": "v\K[^"]+')"
    curl -fsSL "https://github.com/cli/cli/releases/latest/download/gh_${latest_gh_ver}_linux_amd64.tar.gz" | tar -xz
    mv gh_*/bin/gh "$HOME/.local/bin/"
    cd -
    rm -rf "$TEMP_DIR"
else
    echo "gh already installed"
fi

echo "Authenticating with GitHub..."
gh auth login

GITHUB_TOKEN=$(gh auth token)
export GITHUB_TOKEN

echo "Getting chemzoi config..."
if [[ ! -d "$HOME/.local/share/chezmoi" ]]; then
    chezmoi init --apply "git@github.com:hurricanehrndz/cfg.git"
fi

echo "Running chezmoi apply..."
chezmoi apply

echo "Bootstrap complete!"
