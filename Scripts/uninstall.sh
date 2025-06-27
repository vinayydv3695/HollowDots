#!/usr/bin/env bash
# HollowDots Complete Uninstaller
set -eo pipefail

# ---- Configuration ----
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config_backup_*"  # Pattern to match all backups
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[1;33m'
COLOR_RESET='\033[0m'

# ---- Functions ----
function error() {
  echo -e "${COLOR_RED}Error: $1${COLOR_RESET}" >&2
  exit 1
}

function warn() {
  echo -e "${COLOR_YELLOW}Warning: $1${COLOR_RESET}" >&2
}

function restore_backup() {
  echo -e "\n${COLOR_GREEN}Searching for backups...${COLOR_RESET}"
  latest_backup=$(ls -td $BACKUP_DIR | head -1)
  
  if [ -z "$latest_backup" ]; then
    warn "No backup directories found"
    return
  fi

  echo -e "Found backup: $latest_backup"
  read -p "Restore this backup? [y/N] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]] || return

  echo -e "\n${COLOR_GREEN}Restoring configs from backup...${COLOR_RESET}"
  rsync -av --progress "$latest_backup/" "$CONFIG_DIR/" || error "Restore failed"
}

function remove_configs() {
  echo -e "\n${COLOR_GREEN}Removing HollowDots configurations...${COLOR_RESET}"
  
  # List of all config directories we installed
  hollowdots_configs=(
    hypr waybar rofi dunst kitty yazi neovim
    fastfetch ghostty wlogout gtk-2.0 gtk-3.0
    qt5ct qt6ct starship.toml
  )

  for config in "${hollowdots_configs[@]}"; do
    target="$CONFIG_DIR/$config"
    if [ -e "$target" ]; then
      rm -rfv "$target" || warn "Failed to remove $config"
    fi
  done
}

function remove_dependencies() {
  echo -e "\n${COLOR_GREEN}Removing dependencies...${COLOR_RESET}"
  read -p "Remove ALL installed packages? [y/N] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]] || return

  # Packages to remove (excluding core system packages)
  remove_pkgs=(
    waybar rofi-wayland dunst kitty yazi
    swaybg swayidle swaylock playerctl pamixer
    fastfetch ghostty wlogout
  )

  sudo pacman -Rns --noconfirm "${remove_pkgs[@]}" || warn "Failed to remove some packages"
}

# ---- Main Execution ----
clear
echo -e "${COLOR_GREEN}=== HollowDots Uninstaller ===${COLOR_RESET}"
echo -e "This will:"
echo -e "1. Remove all HollowDots config files"
echo -e "2. Optionally restore from backup"
echo -e "3. Optionally remove installed packages"
echo -e "${COLOR_RED}Warning: This is destructive!${COLOR_RESET}"

read -p "Continue? [y/N] " -n 1 -r
echo
[[ $REPLY =~ ^[Yy]$ ]] || exit 0

remove_configs
restore_backup
remove_dependencies

echo -e "\n${COLOR_GREEN}=== Uninstallation Complete ===${COLOR_RESET}"
echo -e "Configurations were removed"
echo -e "Backups remain available at:"
echo -e "$BACKUP_DIR"
