#!/bin/bash

source utils.sh

install_ghostty() {
	"$SUDO_CMD" add-apt-repository ppa:mkasberg/ghostty-ubuntu
	update_cmd
	install_cmd ghostty
}

install_ghostty
