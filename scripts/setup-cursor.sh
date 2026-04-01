#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

install_bibata() {
  local CURSOR_DIR="$HOME/.icons"
  mkdir -p "$CURSOR_DIR"

  local latest_ver=$(curl -s https://api.github.com/repos/ful1e5/Bibata_Cursor/releases/latest | jq -r .tag_name | sed 's/v//')

  local tar_file="Bibata-Modern-Classic.tar.xz"

  if ! curl -LO https://github.com/ful1e5/Bibata_Cursor/releases/download/v${latest_ver}/${tar_file}; then
    echo "Failed to fetch $tar_file"
    return 1
  fi

  if ! tar -xf "$tar_file" -C "$CURSOR_DIR"; then
    echo "Failed to extract $tar_file"
    return 1
  fi

  rm -f "$tar_file"
}
