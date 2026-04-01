#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

install_warp() {
  if [ ! -f /etc/apt/sources.list.d/cloudflare-client.list ]; then
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | "$SUDO_CMD" gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ noble main" | "$SUDO_CMD" tee /etc/apt/sources.list.d/cloudflare-client.list
  fi

  update_cmd
  install_cmd cloudflare-warp
}
