#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/log.sh"

SUDO_LOCAL="/etc/pam.d/sudo_local"

check_sudo() {
    if [ -f "$SUDO_LOCAL" ] && grep -qE "^auth[[:space:]]+sufficient[[:space:]]+pam_tid\.so" "$SUDO_LOCAL"; then
        log_info "Touch ID for sudo already configured."
        return
    fi

    sudo tee "$SUDO_LOCAL" > /dev/null <<'EOF'
# sudo_local: local config file which survives system update and is included for sudo
auth       sufficient     pam_tid.so
EOF
}

check_sudo
