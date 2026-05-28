#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

install_mpv() {
  install_cmd mpv
}

install_obs() {
  install_cmd obs-studio
}

install_entertainment() {
  install_mpv
  install_obs
}
