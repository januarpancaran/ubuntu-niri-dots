#!/bin/bash
set -e

source utils.sh

install_noctalia() {
    "$SUDO_CMD" mkdir -p /etc/apt/keyrings
    if [ ! -f /etc/apt/sources.list.d/noctalia.list ]; then
        curl -fsSL https://pkg.noctalia.dev/gpg.key | "$SUDO_CMD" gpg --dearmor -o /etc/apt/keyrings/noctalia.gpg
        echo "deb [signed-by=/etc/apt/keyrings/noctalia.gpg] https://pkg.noctalia.dev/apt questing main" | "$SUDO_CMD" tee /etc/apt/sources.list.d/noctalia.list
    fi
}

install_niri() {
    "$SUDO_CMD" add-apt-repository -y ppa:avengemedia/danklinux
    install_noctalia

    update_cmd
    install_cmd niri noctalia-shell

    delete_cmd alacritty
}

install_niri
