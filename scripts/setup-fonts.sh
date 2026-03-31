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

    local install_url="https://release-assets.githubusercontent.com/github-production-release-asset/27574418/618d36f5-7bcc-4e03-a153-30d18952aa14?sp=r&sv=2018-11-09&sr=b&spr=https&se=2026-03-31T14%3A31%3A10Z&rscd=attachment%3B+filename%3DJetBrainsMono.zip&rsct=application%2Foctet-stream&skoid=96c2d410-5711-43a1-aedd-ab1947aa7ab0&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skt=2026-03-31T13%3A30%3A19Z&ske=2026-03-31T14%3A31%3A10Z&sks=b&skv=2018-11-09&sig=gxfHNp06p%2BJUP4BSIYxboXlk5kR6X6UO1FKHV5q2BRY%3D&jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmVsZWFzZS1hc3NldHMuZ2l0aHVidXNlcmNvbnRlbnQuY29tIiwia2V5Ijoia2V5MSIsImV4cCI6MTc3NDk2NzgxMCwibmJmIjoxNzc0OTY0MjEwLCJwYXRoIjoicmVsZWFzZWFzc2V0cHJvZHVjdGlvbi5ibG9iLmNvcmUud2luZG93cy5uZXQifQ.F0N5f6i5aCWvARcJbRGuxUdrtEzqxQv7i8AwpbM9mDQ&response-content-disposition=attachment%3B%20filename%3DJetBrainsMono.zip&response-content-type=application%2Foctet-stream"

    local zip_file="JetBrainsMono.zip"

    if ! curl -L -o "$zip_file" "$install_url"; then
        echo "Failed to fetch JetBrains Mono Nerd Font"
    fi

    unzip -o "$zip_file" -d JetBrainsMono
    pushd JetBrainsMono >/dev/null || return 1
    mv *.ttf "$FONT_DIR"
    popd >/dev/null
    fc-cache -vf

    rm -rf JetBrainsMono "$zip_file"
}

install_fonts
user_choice "Windows Fonts" install_windows_fonts
