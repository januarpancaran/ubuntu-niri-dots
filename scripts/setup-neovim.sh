#!/bin/bash

source utils.sh
source dev-packages.sh
source setup-nodejs.sh

install_neovim() {
	"$SUDO_CMD" add-apt-repository ppa:neovim-ppa/unstable
	"$SUDO_CMD" apt update
	"$SUDO_CMD" apt install -y neovim

	install_config
}

install_config() {
	set_config_dir
	set_local_dir

	local NVIM_DIR="${CONF_DIR}/nvim"

	backup_dir "$NVIM_DIR"
	backup_dir "${LOCAL_DIR}/share/nvim"
	backup_dir "${LOCAL_DIR}/state/nvim"
	backup_dir "$HOME/.cache/nvim"

	git clone https://github.com/januarpancaran/neovim-config.git "$NVIM_DIR"

	cd "$NVIM_DIR" || return 1
	rm -rf .git
	rm README.md
}

user_choice "my Neovim config" install_neovim
