#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

DEV_PKGS=(
  cargo
  composer
  dotnet10
  jq
  libxml2-utils
  lua5.4
  liblua5.4-dev
  mysql-server
  openjdk-25-jdk
  php
  postgresql
  python3
  python3-pip
  python3-venv
  ruby-full
  rustc
  sqlite3
)

install_dev_pkgs() {
  install_cmd "${DEV_PKGS[@]}"
  install_homebrew
  install_github_cli
  install_copilot_cli
  install_opencode
  install_nodejs
  install_bun
  install_go
  install_vscode
  install_docker
}

install_homebrew() {
  if ! cmd_exists brew; then
    if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
      echo "Failed to fetch homebrew"
      return 1
    fi
  fi
}

install_github_cli() {
  if ! cmd_exists gh; then
    brew install gh
  fi
}

install_copilot_cli() {
  if ! cmd_exists copilot; then
    brew install --cask copilot-cli
  fi
}

install_opencode() {
  if ! cmd_exists opencode; then
    brew install anomalyco/tap/opencode
  fi
}

install_nodejs() {
  if ! cmd_exists node; then
    brew install node
  fi
}

install_bun() {
  if ! cmd_exists bun; then
    brew install oven-sh/bun/bun
  fi
}

install_go() {
  if ! cmd_exists go; then
    brew install go
  fi
}

install_vscode() {
  if ! cmd_exists code; then
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc |
      gpg --dearmor |
      sudo tee /etc/apt/keyrings/packages.microsoft.gpg > /dev/null

    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] \
      https://packages.microsoft.com/repos/code stable main" |
      sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

    update_cmd
    install_cmd apt-transport-https code
  fi
}

install_docker() {
  install_cmd docker.io docker-buildx docker-compose-v2

  add_group docker
}
