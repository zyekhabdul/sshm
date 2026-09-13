#!/usr/bin/env bash
set -euo pipefail

# sshm Multi-Platform Packaging Master Runner
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

echo "=================================================="
echo "sshm Multi-Platform Packaging Orchestrator"
echo "=================================================="

# 1. Debian / Ubuntu .deb
echo ""
echo "[ 1/2 ] Building Debian (.deb) Package..."
bash "$ROOT_DIR/packaging/debian/build-deb.sh"

# 2. Syntax verification
echo ""
echo "[ 2/2 ] Running deterministic syntax tests..."
bash -n "$ROOT_DIR/bin/sshm"
"$ROOT_DIR/bin/sshm" --version

echo ""
echo "=================================================="
echo "ALL PACKAGES SUCCESSFULLY VERIFIED & BUILT:"
echo "=================================================="
ls -lh "$ROOT_DIR/packaging/debian"/*.deb
echo "=================================================="
