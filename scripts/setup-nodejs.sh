#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

install_nodejs() {
  if cmd_exists node && cmd_exists npm; then
    echo "Node.js already installed"
    return 0
  fi

  local version=24
  local fnm_path="$HOME/.local/share/fnm"
  local install_url="https://fnm.vercel.app/install"

  if ! curl -fsSL "$install_url" | bash; then
    echo "fnm install script failed" >&2
    return 1
  fi

  # Detect install location
  if [ ! -x "$fnm_path/fnm" ]; then
    fnm_path="$HOME/.fnm"
  fi

  if [ ! -x "$fnm_path/fnm" ]; then
    echo "fnm binary not found after installation" >&2
    return 1
  fi

  export PATH="$fnm_path:$PATH"

  local fnm_env
  if ! fnm_env="$("$fnm_path/fnm" env --shell bash)"; then
    echo "fnm environment setup failed" >&2
    return 1
  fi

  echo "Installing Node.js $version via fnm..."
  "$fnm_path/fnm" install "$version" || return 1
  "$fnm_path/fnm" default "$version" || return 1
}

install_bun() {
  if ! curl -fsSL https://bun.com/install | bash; then
    echo "Failed to install Bun"
    return 1
  fi
}
