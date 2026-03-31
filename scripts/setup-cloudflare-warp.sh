#!/bin/bash

source utils.sh

install_warp() {
	curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | "$SUDO_CMD" gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ noble main" | "$SUDO_CMD" tee /etc/apt/sources.list.d/cloudflare-client.list
	"$SUDO_CMD" apt update
	install_cmd cloudflare-warp
}

install_warp
