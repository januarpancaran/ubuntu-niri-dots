#!/bin/bash
THEMES_DIR="$HOME/.themes"
ICONS_DIR="$HOME/.icons"
set_config_dir
GTK4_DIR="$CONF_DIR/gtk-4.0"

install_dracula_gtk() {
  local latest_ver=$(curl -s https://api.github.com/repos/dracula/gtk/releases/latest | jq -r .tag_name | sed 's/v//')
  local tar_file="Dracula.tar.xz"
  mkdir -p "$THEMES_DIR"
  if ! curl -LO https://github.com/dracula/gtk/releases/download/v${latest_ver}/$tar_file; then
    echo "Failed to fetch Dracula theme"
    return 1
  fi
  if ! tar -xf "$tar_file" -C "$THEMES_DIR"; then
    echo "Failed to extract $tar_file"
    return 1
  fi
  rm -f "$tar_file"
}

install_tela_icons() {
  local repo_dir="/tmp/tela-icon-theme"
  if ! git clone --depth=1 https://github.com/vinceliuice/tela-icon-theme "$repo_dir"; then
    echo "Failed to clone Tela icon theme"
    return 1
  fi
  mkdir -p "$ICONS_DIR"
  if ! "$repo_dir/install.sh" nord -d "$ICONS_DIR"; then
    echo "Failed to install Tela icons"
    rm -rf "$repo_dir"
    return 1
  fi
  rm -rf "$repo_dir"
}

install_themes() {
  install_dracula_gtk || return 1
  install_tela_icons || return 1

  mkdir -p "$GTK4_DIR"
  link_file "$THEMES_DIR/Dracula/gtk-4.0/gtk.css" "$GTK4_DIR/gtk.css"
  link_file "$THEMES_DIR/Dracula/gtk-4.0/gtk-dark.css" "$GTK4_DIR/gtk-dark.css"
  link_file "$THEMES_DIR/Dracula/gtk-4.0/assets" "$GTK4_DIR/assets"
}
