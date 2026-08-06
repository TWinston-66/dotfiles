#!/usr/bin/env bash
# curl -fsSL https://raw.githubusercontent.com/TWinston-66/dotfiles/main/bootstrap.sh | bash

set -euo pipefail

REPO_URL="${DOTFILES_REPO_URL:-https://github.com/TWinston-66/dotfiles.git}"
TARGET_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

ensure_git() {
  if command -v git >/dev/null 2>&1; then
    return
  fi

  echo "==> git not found, installing"
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update -y
    sudo apt-get install -y git ca-certificates
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --needed --noconfirm git
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y git ca-certificates
  elif [ "$(uname -s)" = "Darwin" ]; then
    echo "git not found. Run 'xcode-select --install', then re-run this script." >&2
    exit 1
  else
    echo "git not found and no known package manager (apt, pacman, dnf)." >&2
    echo "Install git manually, then re-run this script." >&2
    exit 1
  fi
}

ensure_git

if [ -d "$TARGET_DIR/.git" ]; then
  echo "==> dotfiles repo already present at $TARGET_DIR, pulling latest"
  git -C "$TARGET_DIR" pull --ff-only
else
  echo "==> cloning dotfiles to $TARGET_DIR"
  git clone "$REPO_URL" "$TARGET_DIR"
fi

exec "$TARGET_DIR/dotfiles.sh" "$@"
