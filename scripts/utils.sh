#!/bin/bash

cmd_exists() {
  command -v "$1" > /dev/null 2>&1
}

SUDO_CMD=""

if cmd_exists doas; then
  SUDO_CMD="doas"
else
  SUDO_CMD="sudo"
fi

set_config_dir() {
  CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
  mkdir -p "$CONF_DIR"
}

set_local_dir() {
  LOCAL_DIR="$HOME/.local"
  mkdir -p "$LOCAL_DIR"
}

backup_dir() {
  local dir="$1"
  [ -d "$dir" ] && mv -v "$dir" "${dir}.bak"
}

backup_file() {
  local file="$1"
  [ -f "$file" ] && mv -v "$file" "${file}.bak"
}

install_cmd() {
  "$SUDO_CMD" apt install -y "$@"
}

update_cmd() {
  "$SUDO_CMD" apt update
}

delete_cmd() {
  "$SUDO_CMD" apt purge -y "$@"
}

link_file() {
  mkdir -p "$(dirname "$2")"
  ln -sf "$1" "$2"
}

add_group() {
  "$SUDO_CMD" usermod -aG "$1" $USER
}

user_choice() {
  local label="$1"
  shift

  read -rp "Install optional ${label}? [y/N] " choice

  case "$choice" in
  [Yy])
    echo "Installing ${label}..."
    "$@"
    ;;
  *)
    echo "Skipping ${label}"
    ;;
  esac
}

UTILS=(
  bat
  build-essential
  curl
  fastfetch
  fzf
  git
  gpg
  htop
  jq
  libgmp-dev
  libyaml-dev
  policykit-1-gnome
  ripgrep
  software-properties-common
  starship
  tar
  tmux
  trash-cli
  tree
  unrar
  unzip
  wget
  wl-clipboard
  wl-mirror
  zip
  zlib1g-dev
  zoxide
  zsh
)

install_utils() {
  install_cmd "${UTILS[@]}"
}
