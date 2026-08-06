#!/usr/bin/env bash

set -euo pipefail

install_linux_apps() {
    log_step "Installing Linux Apps"
    install_manager
    install_zed_linux
    am -ia helium
    am -e pkgforge-dev/ghostty-appimage ghostty aarch64
    am -e sourcegit-scm/sourcegit sourcegit arm64
    am -e cryptomator/cryptomator cryptomator aarch64
}

install_manager() {
  if command -v am >/dev/null 2>&1; then
    log_info "AM already installed"
    return
  fi

  log_step "Installing AM"
  local tmpdir
  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' EXIT

  curl -fsSL -o "$tmpdir/INSTALL" https://raw.githubusercontent.com/ivan-hc/AM/main/INSTALL
  chmod a+x "$tmpdir/INSTALL"
  sudo "$tmpdir/INSTALL"

  rm -rf "$tmpdir"
  trap - EXIT
}

install_zed_linux() {
  if command -v zed >/dev/null 2>&1; then
    log_info "Zed already installed"
    return
  fi
  log_step "Installing Zed"
  curl -fsSL https://zed.dev/install.sh | sh
}
