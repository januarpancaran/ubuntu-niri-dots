#!/bin/bash

source utils.sh

install_ghostty() {
	"$SUDO_CMD" add-apt-repository ppa:mkasberg/ghostty-ubuntu
	"$SUDO_CMD" apt update
	"$SUDO_CMD" apt install ghostty
}

install_ghostty
