# sshm

Interactive SSH Host Manager with live metadata preview powered by `fzf` and `ssh -G`.

---

## Overview

`sshm` is a lightweight, zero-dependency POSIX/Bash CLI utility that transforms your OpenSSH `~/.ssh/config` into a searchable, interactive fuzzy selector. It renders real-time connection parameters (Hostname, User, Port, IdentityFile, ProxyJump, ForwardAgent) in a split preview window before connecting.

## Features

- **Recursive Config Resolution**: Parses `~/.ssh/config` and resolves nested `Include` statements (e.g. `Include ~/.ssh/config.d/*`).
- **Interactive Metadata Preview**: Uses OpenSSH canonical evaluation (`ssh -G`) to display effective connection details dynamically.
- **Deduplication & Wildcard Filtering**: Eliminates redundant alias entries and filters out wildcard matchers (`*`, `?`, `!`).
- **Transparent Argument Forwarding**: Directly executing `sshm hostname` bypasses the picker and invokes native `ssh`. Any standard flags (`-p`, `-v`, `-L`, `-D`) are preserved.
- **Zero Heavy Dependencies**: Pure Bash script requiring only `openssh` and `fzf`.

## Requirements

- `bash` (>= 4.0)
- `openssh` (`ssh`)
- `fzf` (command-line fuzzy finder)

## Installation

### Option 1: 1-Line Standalone Installer (Linux / macOS / Termux)

```bash
curl -fsSL https://raw.githubusercontent.com/zyekhabdul/sshm/main/install.sh | bash
```

### Option 2: Arch Linux (AUR & PKGBUILD)

```bash
# Using an AUR helper:
yay -S sshm-git
# or paru -S sshm-git

# Manual PKGBUILD build:
git clone https://github.com/zyekhabdul/sshm.git
cd sshm/packaging/aur-git
makepkg -si
```

### Option 3: Debian / Ubuntu (.deb)

Download and install the prebuilt `.deb` package from releases or build locally:

```bash
# Build locally:
bash packaging/debian/build-deb.sh
sudo dpkg -i packaging/debian/sshm_1.1.0_all.deb
```

### Option 4: macOS / Linux Homebrew

```bash
brew install zyekhabdul/tap/sshm
# Or install directly from formula:
brew install packaging/homebrew/sshm.rb
```

### Option 5: Termux (Android)

```bash
curl -fsSL https://raw.githubusercontent.com/zyekhabdul/sshm/main/packaging/termux/build.sh | bash
```

### Option 6: Manual Clone (Makefile)

```bash
git clone https://github.com/zyekhabdul/sshm.git
cd sshm
make install
```
*Installs by default to `~/.local/bin/sshm`. For system-wide install, run `sudo make install PREFIX=/usr/local`.*

## Usage

### Interactive Selection

Run `sshm` without arguments to launch the fuzzy selector:

```bash
sshm
```

Use arrow keys or `Ctrl-J`/`Ctrl-K` to navigate, type to filter hosts, and press `Enter` to connect. Press `Esc` or `Ctrl-C` to exit.

### Direct & Forwarding Modes

```bash
# List all parsed hosts (scripting & tab completion)
sshm -l

# Use custom SSH config file
sshm -c ~/.ssh/work_config

# Connect directly to a host (skips fzf)
sshm production-vps

# Execute remote command directly
sshm production-vps "docker ps"

# Forward standard SSH options
sshm -v -p 2222 custom-node
```

## Environment Variables

| Variable | Default | Description |
| :--- | :--- | :--- |
| `SSHM_CONFIG` | `~/.ssh/config` | Path to primary SSH configuration file |
| `SSHM_PROMPT` | `[ SSH Connect ] > ` | Custom prompt string for fzf |
| `SSHM_PREVIEW_FIELDS` | `hostname\|user\|port\|identityfile\|proxyjump\|forwardagent` | Regex of fields evaluated by `ssh -G` |

## License

MIT License. Copyright (c) 2026 Zyekh Abdul (zyekhabdul).
