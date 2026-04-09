#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

install_mpv() {
  install_cmd mpv
}

install_obs() {
  install_cmd obs-studio
}

install_spotify() {
  if ! cmd_exists spotify; then
    if [ ! -f /etc/apt/sources.list.d/spotify.list ]; then
      if ! curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | "$SUDO_CMD" gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg; then
        echo "Failed to fetch spotify key"
        return 1
      fi

      echo "deb https://repository.spotify.com stable non-free" | "$SUDO_CMD" tee /etc/apt/sources.list.d/spotify.list

      update_cmd
      install_cmd spotify-client
    fi
  fi
}

install_entertainment() {
  install_mpv
  install_obs
  install_spotify
}
