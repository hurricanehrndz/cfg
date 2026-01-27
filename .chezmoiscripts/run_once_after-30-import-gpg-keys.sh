#!/bin/bash
set -e

GPG_DIR="{{ .chezmoi.sourceDir }}/identities/gpg"
ULTIMATE_TRUST_KEY="0x0D2565B7C6058A69"

if ! command -v gpg &>/dev/null; then
    echo "gpg not found, skipping key import"
    exit 0
fi

# Import all keys from identities/gpg/
for key_file in "$GPG_DIR"/*.asc; do
    [ -f "$key_file" ] || continue

    key_id=$(basename "$key_file" .asc)

    if gpg --list-keys "$key_id" &>/dev/null; then
        echo "Key $key_id already imported, skipping"
        continue
    fi

    echo "Importing $key_id..."
    gpg --import "$key_file"

    if [ "$key_id" = "$ULTIMATE_TRUST_KEY" ]; then
        echo "Setting ultimate trust (6) for $key_id"
        echo "$key_id:6:" | gpg --import-ownertrust
    else
        echo "Setting full trust (5) for $key_id"
        echo "$key_id:5:" | gpg --import-ownertrust
    fi
done

echo "GPG keys imported successfully"
