#!/usr/bin/env bash
# Termux installer script for sshm
set -euo pipefail

PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
BINDIR="$PREFIX/bin"

echo "==> Installing sshm for Termux in $BINDIR..."
mkdir -p "$BINDIR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
install -m 755 "$SCRIPT_DIR/bin/sshm" "$BINDIR/sshm"

echo "==> Verifying dependencies in Termux..."
if ! command -v fzf >/dev/null 2>&1; then
    echo "==> Warning: fzf is not installed. Installing via pkg..."
    pkg install -y fzf openssh
fi

echo "==> Success! Run 'sshm' to launch."
