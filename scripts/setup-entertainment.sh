#!/bin/bash

source utils.sh

install_vlc() {
	install_cmd vlc
}

install_discord() {
	local latest_ver=0.0.131
	local pkg_name="discord-${latest_ver}.deb"
	local install_url="https://stable.dl2.discordapp.net/apps/linux/${latest_ver}/${pkg_name}"

	if ! curl -LO ${install_url}; then
		echo "Failed to fetch discord"
		return 1
	fi

	if ! install_cmd "./${pkg_name}"; then
		echo "Failed to install discord"
		return 1
	fi

	rm -f "${pkg_name}"
}

install_spotify() {
	if [ ! -f /etc/apt/sources.list.d/spotify.list ]; then
		if ! curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | "$SUDO_CMD" gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg; then
			echo "Failed to fetch spotify key"
			return 1
		fi

		echo "deb https://repository.spotify.com stable non-free" | "$SUDO_CMD" tee /etc/apt/sources.list.d/spotify.list

		update_cmd
		install_cmd spotify-client
	fi
}

install_entertainment() {
	install_vlc
	install_discord
	install_spotify
}

install_entertainment
