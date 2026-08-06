#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_DIR

source "$DOTFILES_DIR/lib/os.sh"
source "$DOTFILES_DIR/lib/log.sh"
source "$DOTFILES_DIR/lib/homebrew.sh"
source "$DOTFILES_DIR/lib/stow.sh"
source "$DOTFILES_DIR/linux/packages.sh"

main() {
    detect_os
    log_title "dotfiles manager — $DOTFILES_OS ${DOTFILES_LINUX_FAMILY:-}"

    sudo_keepalive
    install_native_prereqs

    shared_packages
    if [ "$DOTFILES_OS" = "linux" ]; then
        install_linux_apps
    fi

    stow_packages

    set_default_shell
    os_specific_setup

    log_title "Done"
    log_ok "Machine configured. Follow steps below."
    log_info "1. run \`sudo tailscale up\`"
}

sudo_keepalive() {
  sudo -v
  while true; do sudo -n true; sleep 120; kill -0 "$$" || exit; done 2>/dev/null &
}

login_shell() {
  local user
  user="$(id -un)"

  if [ "$DOTFILES_OS" = "macos" ]; then
    dscl . -read "/Users/$user" UserShell 2>/dev/null | awk '{print $2}'
  else
    getent passwd "$user" 2>/dev/null | cut -d: -f7
  fi
}

set_default_shell() {
  local zsh_path current
  zsh_path="$(command -v zsh)"

  current="$(login_shell || true)"
  [ -n "$current" ] || current="${SHELL:-}"

  if [ "$current" = "$zsh_path" ]; then
    log_info "zsh already the default shell"
    return
  fi

  log_step "Setting zsh as default shell"
  if ! grep -qx "$zsh_path" /etc/shells; then
    echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
  fi
  sudo chsh -s "$zsh_path" "$(id -un)"
}


os_specific_setup() {
  case "$DOTFILES_OS" in
    macos)
      run_step "Applying macOS defaults" bash "$DOTFILES_DIR/macos/defaults.sh"

      log_step "Setting up Touch ID for sudo"
      sudo -v
      bash "$DOTFILES_DIR/macos/touch-sudo.sh"
      ;;
    linux) : ;;
  esac
}

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

main "$@"
