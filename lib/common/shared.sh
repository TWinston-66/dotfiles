#!/usr/bin/env bash

set -euo pipefail

shared_packages() {
    install_homebrew
    brew_bundle "$DOTFILES_DIR/Brewfile"
    install_tailscale
}

install_tailscale() {
    if command -v tailscale >/dev/null 2>&1; then
      log_info "Tailscale already installed"
      return
    fi
    log_step "Installing Tailscale"
    curl -fsSL https://tailscale.com/install.sh | sh
}