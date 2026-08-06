#!/usr/bin/env bash

set -euo pipefail

has_gum() { command -v gum >/dev/null 2>&1; }

log_title() {
  if has_gum; then
    gum style --border double --margin "1 0" --padding "0 2" --border-foreground 212 --bold "$1"
  else
    echo -e "\n=== $1 ===\n"
  fi
}

log_step() {
  if has_gum; then
    gum style --foreground 212 "▸ $1"
  else
    echo "==> $1"
  fi
}

log_info() {
  if has_gum; then
    gum style --foreground 245 "  $1"
  else
    echo "    $1"
  fi
}

log_ok() {
  if has_gum; then
    gum style --foreground 82 "✔ $1"
  else
    echo "OK: $1"
  fi
}

log_err() {
  if has_gum; then
    gum style --foreground 196 --bold "✖ $1"
  else
    echo "ERROR: $1" >&2
  fi
}

run_step() {
  local label="$1"; shift
  if has_gum; then
    gum spin --spinner dot --title "$label" -- "$@"
  else
    log_step "$label"
    "$@"
  fi
}

confirm() {
  if has_gum; then
    gum confirm "$1"
  else
    read -r -p "$1 [y/N] " ans
    [[ "$ans" =~ ^[Yy]$ ]]
  fi
}
