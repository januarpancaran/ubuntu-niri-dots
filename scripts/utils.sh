#!/bin/bash

cmd_exists() {
	command -v "$1" >/dev/null 2>&1
}

SUDO_CMD=""

if cmd_exists doas; then
	SUDO_CMD="doas"
else
	SUDO_CMD="sudo"
fi

user_choice() {
	local label="$1"
	shift

	read -r -p "Install optional ${label}? [y/N] " choice

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

install_cmd() {
	"$SUDO_CMD" apt install -y "$@"
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
	ripgrep
	software-properties-common
	tar
	tmux
	trash-cli
	tree
	unrar
	unzip
	wget
	wl-clipboard
	zip
	zlib1g-dev
	zoxide
	zsh
)

install_utils() {
	install_cmd "${UTILS[@]}"
}

install_utils
