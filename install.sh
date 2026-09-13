#!/usr/bin/env bash
# Standalone 1-line installer for sshm
set -euo pipefail

INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
mkdir -p "$INSTALL_DIR"

echo "==> Installing sshm to $INSTALL_DIR/sshm..."
curl -fsSL https://raw.githubusercontent.com/zyekhabdul/sshm/main/bin/sshm -o "$INSTALL_DIR/sshm"
chmod +x "$INSTALL_DIR/sshm"

echo "==> Checking dependencies..."
if ! command -v fzf >/dev/null 2>&1; then
    echo "[ NOTE ] 'fzf' is required for interactive mode. Please install fzf via your package manager."
fi

echo "==> Installation complete! Run 'sshm' or add $INSTALL_DIR to your PATH if not already present."
