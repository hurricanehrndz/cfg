#!/bin/bash
set -e

TOOLS_DIR="$HOME/.local/share/tools"
BIN_DIR="$HOME/.local/bin"
MAN_DIR="$HOME/.local/share/man"
COMP_DIR="$HOME/.local/share/zsh/site-functions"

mkdir -p "$BIN_DIR" "$MAN_DIR/man1" "$COMP_DIR"

# Clean up dead symlinks in bin, man, and completions
find "$BIN_DIR" -xtype l -delete 2>/dev/null || true
find "$MAN_DIR" -xtype l -delete 2>/dev/null || true
find "$COMP_DIR" -xtype l -delete 2>/dev/null || true

# Symlink all binaries
find "$TOOLS_DIR" -maxdepth 2 -type f -executable -not -name "*.so*" 2>/dev/null | while read -r bin; do
    ln -sf "$bin" "$BIN_DIR/$(basename "$bin")"
done

# Symlink man pages
find "$TOOLS_DIR" -type f \( -name "*.1" -o -name "*.1.gz" \) 2>/dev/null | while read -r man; do
    ln -sf "$man" "$MAN_DIR/man1/$(basename "$man")"
done

# Symlink completions (multiple possible locations)
find "$TOOLS_DIR" -type f \( -path "*/completions/_*" -o -path "*/autocomplete/_*" -o -path "*/completions/*.zsh" -o -path "*/autocomplete/*.zsh" -o -path "*/completion.zsh" \) 2>/dev/null | while read -r comp; do
    filename=$(basename "$comp")
    if [[ "$filename" == _* ]]; then
        ln -sf "$comp" "$COMP_DIR/$filename"
    else
        tool_name=$(basename "$(dirname "$(dirname "$comp")")")
        ln -sf "$comp" "$COMP_DIR/_${tool_name}"
    fi
done
