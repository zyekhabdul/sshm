#!/usr/bin/env bash
# Standalone 1-line installer for sshm
set -euo pipefail

# Auto-detect Termux environment ($PREFIX/bin) vs standard Linux/macOS ($HOME/.local/bin)
if [ -n "${PREFIX:-}" ] && [ -d "${PREFIX}/bin" ]; then
    DEFAULT_DIR="${PREFIX}/bin"
    IS_TERMUX=1
else
    DEFAULT_DIR="$HOME/.local/bin"
    IS_TERMUX=0
fi

INSTALL_DIR="${INSTALL_DIR:-$DEFAULT_DIR}"
mkdir -p "$INSTALL_DIR"

echo "==> Installing sshm to $INSTALL_DIR/sshm..."
curl -fsSL https://raw.githubusercontent.com/zyekhabdul/sshm/main/bin/sshm -o "$INSTALL_DIR/sshm"
chmod +x "$INSTALL_DIR/sshm"

echo "==> Checking dependencies..."
if ! command -v fzf >/dev/null 2>&1; then
    if [ "$IS_TERMUX" -eq 1 ]; then
        echo "[ NOTE ] Installing fzf and openssh via pkg in Termux..."
        pkg install -y fzf openssh
    else
        echo "[ NOTE ] 'fzf' is required for interactive mode. Please install fzf via your package manager."
    fi
fi

echo "==> Installation complete! Run 'sshm' or add $INSTALL_DIR to your PATH if not already present."
