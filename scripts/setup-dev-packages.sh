#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

DEV_PKGS=(
  composer
  dotnet-sdk-10.0
  golang
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
  install_github_cli
  install_copilot_cli
  install_opencode
  install_vscode
  install_docker
}

install_github_cli() {
  if ! cmd_exists gh; then
    local latest_ver=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | jq -r .tag_name | sed 's/v//')

    local pkg_name="gh_${latest_ver}_linux_amd64.deb"

    if ! curl -LO https://github.com/cli/cli/releases/download/v${latest_ver}/${pkg_name}; then
      echo "Failed to fetch github cli"
      return 1
    fi

    if ! install_cmd "./${pkg_name}"; then
      echo "Failed to install github cli"
      return 1
    fi

    rm -f "${pkg_name}"
  fi
}

install_copilot_cli() {
  if ! cmd_exists copilot; then
    if ! curl -fsSL https://gh.io/copilot-install | bash; then
      echo "Failed to install copilot cli"
      return 1
    fi
  fi
}

install_opencode() {
  if ! cmd_exists opencode; then
    if ! curl -fsSL https://opencode.ai/install | bash; then
      echo "Failed to install opencode"
      return 1
    fi
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
