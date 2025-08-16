#!/usr/bin/env bash
# HollowDots Refined Installer

set -eo pipefail

# ---- Configuration ----
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
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

function backup_and_symlink() {
  info "\nBacking up existing configs and creating symbolic links..."
  mkdir -p "$BACKUP_DIR"
  mkdir -p "$CONFIG_DIR"

  for item in "$DOTFILES_DIR/.config"/*;
 do
    local config_name
    config_name=$(basename "$item")
    local target_path="$CONFIG_DIR/$config_name"

    if [ -e "$target_path" ]; then
      if [ -L "$target_path" ]; then
        info "Removing existing symlink for $config_name"
        rm "$target_path"
      else
        info "Backing up existing $config_name"
        mv "$target_path" "$BACKUP_DIR/"
      fi
    fi

    info "Creating symlink for $config_name"
    ln -sf "$item" "$target_path"
  done
}

function install_packages() {
  info "\nInstalling required packages..."
  if ! command -v yay &>/dev/null; then
    warn "yay not found - installing..."
    sudo pacman -S --needed --noconfirm git base-devel || error "Failed to install build tools"
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    (cd /tmp/yay-bin && makepkg -si --noconfirm) || error "Failed to install yay"
  fi

  if [ -f "$DOTFILES_DIR/packages.txt" ]; then
    yay -S --needed --noconfirm - < "$DOTFILES_DIR/packages.txt" || error "Failed to install packages"
  else
    warn "packages.txt not found, skipping package installation."
  fi
}

# ---- Main Execution ----
clear
info "=== HollowDots Refined Installation ==="
echo -e "This script will:"
echo -e "1. Back up your existing configuration files."
echo -e "2. Install the required packages from packages.txt."
echo -e "3. Create symbolic links for the dotfiles in ~/.config."
echo -e "${COLOR_YELLOW}Note: This is a non-destructive operation that uses symbolic links.${COLOR_RESET}"

read -p "Continue? (y/N) " -n 1 -r
[[ ! $REPLY =~ ^[Yy]$ ]] && exit 1

install_packages
backup_and_symlink

info "\n=== Installation Complete ==="
echo -e "Your original configs were saved to: $BACKUP_DIR"
echo -e "\nNext steps:"
echo -e "1. Reboot your system."
echo -e "2. Customize your setup by editing the files in the repository."