#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

install_neovim() {
  "$SUDO_CMD" add-apt-repository ppa:neovim-ppa/unstable
  update_cmd
  install_cmd neovim

  install_config
}

install_config() {
  set_config_dir
  set_local_dir

  local nvim_dir="${CONF_DIR}/nvim"

  [ -e "$nvim_dir" ] && backup_dir "$nvim_dir"
  [ -e "${LOCAL_DIR}/share/nvim" ] && backup_dir "${LOCAL_DIR}/share/nvim"
  [ -e "${LOCAL_DIR}/state/nvim" ] && backup_dir "${LOCAL_DIR}/state/nvim"
  [ -e "$HOME/.cache/nvim" ] && backup_dir "$HOME/.cache/nvim"

  git clone https://github.com/januarpancaran/neovim-config.git "$nvim_dir"

  pushd "$nvim_dir" > /dev/null || return 1
  rm -rf .git
  rm -f README.md
  popd > /dev/null || return 1

  if cmd_exists npm; then
    npm install -g tree-sitter-cli
  fi
}
