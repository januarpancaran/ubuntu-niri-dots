#!/bin/bash
set -e

source utils.sh

choose_browser() {
	echo "Choose your preferred browser from this list"
	echo "1. Firefox (snap)"
	echo "2. Firefox ESR (apt)"
	echo "3. Google Chrome"
	echo "4. Microsoft Edge"

	read -rp "Enter your choice: " browser_choice

	case "$browser_choice" in
	1)
		echo "Installing Firefox from snap..."
		"$SUDO_CMD" snap install firefox
		;;
	2)
		if snap list | grep -q '^firefox'; then
			echo "Firefox (snap) is already installed."
			read -rp "Remove Firefox snap and install ESR? [y/N] " confirm
			if [[ "$confirm" =~ ^[Yy]$ ]]; then
				"$SUDO_CMD" snap remove firefox
			else
				echo "Skipping Firefox ESR installation."
				exit 1
			fi
		fi

		echo "Installing Firefox ESR from apt..."
		update_cmd
		install_cmd firefox-esr
		;;
	3)
		local name="google-chrome-stable.deb"
		local install_url="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

		curl -L -o "$name" "$install_url"
		install_cmd "./$name"
		rm -f "$name"
		;;
	4)
		if [ ! -f /etc/apt/sources.list.d/microsoft-edge.list ]; then
			wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | "$SUDO_CMD" gpg --dearmor -o /etc/apt/trusted.gpg.d/microsoft.gpg

			echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" | "$SUDO_CMD" tee /etc/apt/sources.list.d/microsoft-edge.list
		fi

		update_cmd
		install_cmd microsoft-edge-stable
		;;
	*)
		echo "Invalid choice."
		exit 1
		;;
	esac
}

choose_browser
