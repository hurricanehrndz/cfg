#!/usr/bin/env zsh
# vim:set ft=zsh sw=2 sts=2 ts=2 et:

[[ -z "$HOMEBREW_PREFIX" ]] && return

path=("$HOME/.local/bin" "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $path)
