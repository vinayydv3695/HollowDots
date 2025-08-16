#!/usr/bin/env bash
# HollowDots Refined Uninstaller

set -eo pipefail

# ---- Configuration ----
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config_backup_*"
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

function info() {
  echo -e "${COLOR_GREEN}$1${COLOR_RESET}"
}

function remove_symlinks() {
  info "\nRemoving symbolic links..."
  for item in "$DOTFILES_DIR/.config"/*;
  do
    local config_name
    config_name=$(basename "$item")
    local target_path="$CONFIG_DIR/$config_name"

    if [ -L "$target_path" ]; then
      info "Removing symlink for $config_name"
      rm "$target_path"
    fi
  done
}

function restore_backup() {
  info "\nRestoring backed-up configurations..."
  local latest_backup
  latest_backup=$(ls -td $BACKUP_DIR 2>/dev/null | head -1)

  if [ -z "$latest_backup" ]; then
    warn "No backup directories found."
    return
  fi

  info "Found backup: $latest_backup"
  read -p "Restore this backup? (y/N) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rsync -av "$latest_backup/" "$CONFIG_DIR/" || warn "Failed to restore some files."
    info "Backup restored."
  fi
}

function uninstall_packages() {
  info "\nUninstalling packages..."
  read -p "Do you want to uninstall all the packages listed in packages.txt? (y/N) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f "$DOTFILES_DIR/packages.txt" ]; then
      sudo pacman -Rns --noconfirm - < "$DOTFILES_DIR/packages.txt" || warn "Failed to uninstall some packages."
      info "Packages uninstalled."
    else
      warn "packages.txt not found, skipping package uninstallation."
    fi
  fi
}

# ---- Main Execution ----
clear
info "=== HollowDots Refined Uninstaller ==="
echo -e "This script will:"
echo -e "1. Remove the symbolic links for the dotfiles."
echo -e "2. Offer to restore your previous configurations from a backup."
echo -e "3. Offer to uninstall the packages that were installed."
echo -e "${COLOR_RED}Warning: This will remove the HollowDots configurations.${COLOR_RESET}"

read -p "Continue? (y/N) " -n 1 -r
[[ ! $REPLY =~ ^[Yy]$ ]] && exit 1

remove_symlinks
restore_backup
uninstall_packages

info "\n=== Uninstallation Complete ==="
echo -e "HollowDots has been uninstalled."
