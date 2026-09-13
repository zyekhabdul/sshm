#!/usr/bin/env bash
set -euo pipefail

PKG_NAME="sshm"
PKG_VER="1.1.0"
PKG_ARCH="all"
DIST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK_DIR="$DIST_DIR/build_deb/${PKG_NAME}_${PKG_VER}_${PKG_ARCH}"

echo "==> Building Debian (.deb) package for $PKG_NAME v$PKG_VER..."
rm -rf "$DIST_DIR/build_deb"
mkdir -p "$WORK_DIR/DEBIAN"
mkdir -p "$WORK_DIR/usr/bin"
mkdir -p "$WORK_DIR/usr/share/doc/$PKG_NAME"

cat << 'EOF' > "$WORK_DIR/DEBIAN/control"
Package: sshm
Version: 1.1.0
Section: utils
Priority: optional
Architecture: all
Depends: bash (>= 4.0), openssh-client, fzf
Maintainer: zyekhabdul <zyekhabdulqadirjailani@gmail.com>
Description: Interactive SSH Fuzzy Manager with Live Metadata Preview
 sshm is a lightweight CLI utility that transforms your OpenSSH ~/.ssh/config
 into a searchable, interactive fuzzy selector using fzf with real-time metadata
 preview via ssh -G.
EOF

PROJECT_ROOT="$(cd "$DIST_DIR/../.." && pwd)"
cp "$PROJECT_ROOT/bin/sshm" "$WORK_DIR/usr/bin/sshm"
chmod 755 "$WORK_DIR/usr/bin/sshm"

cp "$PROJECT_ROOT/README.md" "$WORK_DIR/usr/share/doc/$PKG_NAME/"
cp "$PROJECT_ROOT/LICENSE" "$WORK_DIR/usr/share/doc/$PKG_NAME/copyright"

dpkg-deb --build --root-owner-group "$WORK_DIR" "$DIST_DIR/${PKG_NAME}_${PKG_VER}_${PKG_ARCH}.deb"
rm -rf "$DIST_DIR/build_deb"

echo "==> Done! Created: $DIST_DIR/${PKG_NAME}_${PKG_VER}_${PKG_ARCH}.deb"
