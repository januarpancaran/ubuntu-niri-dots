#!/bin/bash

source utils.sh

FONTS=(
	fonts-noto-cjk
	fonts-noto-color-emoji
)

install_fonts() {
	install_cmd "${FONTS[@]}"
	install_jetbrains_nerd_font
}

install_windows_fonts() {
	install_cmd ttf-mscorefonts-installer
}

install_jetbrains_nerd_font() {
	local FONT_DIR="$HOME/.fonts"
	mkdir -p "$FONT_DIR"

	local latest_ver=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r .tag_name | sed 's/v//')

	local zip_file="JetBrainsMono.zip"

	if ! curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v${latest_ver}/${zip_file}; then
		echo "Failed to fetch JetBrains Mono Nerd Font"
		return 1
	fi

	if ! unzip -o "$zip_file" -d JetBrainsMono; then
		echo "Failed to unzip $zip_file"
		return 1
	fi

	pushd JetBrainsMono >/dev/null || return 1
	mv *.ttf "$FONT_DIR"
	popd >/dev/null
	fc-cache -vf

	rm -rf JetBrainsMono "$zip_file"
}

install_fonts
user_choice "Windows Fonts" install_windows_fonts
