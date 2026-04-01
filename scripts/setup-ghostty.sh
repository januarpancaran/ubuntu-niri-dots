#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

install_ghostty() {
  "$SUDO_CMD" add-apt-repository ppa:mkasberg/ghostty-ubuntu
  update_cmd
  install_cmd ghostty
}
