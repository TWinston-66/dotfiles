#!/usr/bin/env bash

set -euo pipefail

DOTFILES_STOW_PACKAGES=(git zsh zed)

stow_packages() {
  log_step "Stowing dotfiles"

  local backup_dir="$HOME/.dotfiles-backup/$(date +%Y%m%d%H%M%S)"
  local backed_up=0
  local pkg file rel target

  for pkg in "${DOTFILES_STOW_PACKAGES[@]}"; do
    while IFS= read -r file; do
      rel="${file#"$DOTFILES_DIR/$pkg/"}"
      target="$HOME/$rel"
      if [ -e "$target" ] && [ ! -L "$target" ]; then
        log_info "Backing up existing $target"
        mkdir -p "$backup_dir/$(dirname "$rel")"
        mv "$target" "$backup_dir/$rel"
        backed_up=1
      fi
    done < <(find "$DOTFILES_DIR/$pkg" -type f)
  done

  if [ "$backed_up" -eq 1 ]; then
    log_info "Pre-existing dotfiles backed up to $backup_dir"
  fi

  stow --dir="$DOTFILES_DIR" --target="$HOME" --restow "${DOTFILES_STOW_PACKAGES[@]}"
  log_ok "Dotfiles stowed"
}
