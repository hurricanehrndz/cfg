#!/bin/bash
set -e

export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export PATH="$XDG_BIN_HOME:$PATH"

if command -v gh &>/dev/null; then
    if gh auth status &>/dev/null; then
        export GITHUB_TOKEN=$(gh auth token)
    fi
fi
