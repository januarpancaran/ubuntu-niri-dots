#!/bin/bash

source utils.sh

DEV_PKGS=(
	composer
	dotnet-sdk-10.0
	golang
	jq
	libxml2-utils
	lua5.4
	mysql-server
	openjdk-25-jdk
	php
	postgresql
	python3
	python3-pip
	python3-venv
	rustc
	sqlite3
)

install_dev_pkgs() {
	install_cmd "${DEV_PKGS[@]}"
}

user_choice "dev packages" install_dev_pkgs
