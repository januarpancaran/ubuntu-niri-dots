#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$ROOT_DIR/scripts"

# imports
source "$SCRIPTS_DIR/utils.sh"
source "$SCRIPTS_DIR/setup-browser.sh"
source "$SCRIPTS_DIR/setup-cloudflare-warp.sh"
source "$SCRIPTS_DIR/setup-cursor.sh"
source "$SCRIPTS_DIR/setup-dev-packages.sh"
source "$SCRIPTS_DIR/setup-entertainment.sh"
source "$SCRIPTS_DIR/setup-fonts.sh"
source "$SCRIPTS_DIR/setup-ghostty.sh"
source "$SCRIPTS_DIR/setup-neovim.sh"
source "$SCRIPTS_DIR/setup-niri.sh"
source "$SCRIPTS_DIR/setup-theme.sh"
source "$SCRIPTS_DIR/setup-nodejs.sh"

copy_configs() {
  echo "Copying config files..."

  set_config_dir

  local -a conf_dirs=(
    fastfetch
    ghostty
    mpv
    niri
    noctalia
    tmux
    starship
  )

  local -a home_files=(
    .bashrc
    .zshrc
  )

  for dir in "${conf_dirs[@]}"; do
    local src="$ROOT_DIR/src/$dir"
    [ -d "$src" ] || continue

    local dest="${CONF_DIR}/$dir"

    [ -e "$dest" ] && backup_dir "$dest"

    cp -r "$src" "$dest"
    echo "Copied $src -> $dest"
  done

  for file in "${home_files[@]}"; do
    local src="$ROOT_DIR/src/$file"
    [ -f "$src" ] || continue

    local dest="$HOME/$file"
    [ -f "$dest" ] && backup_file "$dest"

    cp "$src" "$dest"
    echo "Copied $src -> $dest"
  done
}

install_tmux_tpm() {
  set_config_dir

  local tpm_dir="${CONF_DIR}/tmux/plugins/tpm"

  mkdir -p "$(dirname "$tpm_dir")"

  [ ! -d "$tpm_dir" ] && git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
}

change_shell() {
  read -rp "Change shell to zsh? [y/N] " shell_choice

  case "$shell_choice" in
  [Yy])
    chsh -s "$(command -v zsh)"
    ;;
  *)
    echo "Shell not changed"
    ;;
  esac
}

main() {
  update_cmd
  install_utils
  install_niri
  install_warp
  install_bibata
  install_themes
  install_fonts
  install_ghostty
  install_entertainment
  copy_configs
  install_tmux_tpm
  choose_browser

  user_choice "Windows Fonts" install_windows_fonts
  user_choice "Node.js 24 LTS" install_nodejs
  user_choice "Bun" install_bun
  user_choice "Development packages" install_dev_pkgs
  user_choice "My Neovim Config" install_neovim

  add_group video
  change_shell

  echo "Installation finished!"
}

main "$@"
