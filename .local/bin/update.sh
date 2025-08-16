#!/usr/bin/env bash
# HollowDots Refined Updater

set -eo pipefail

# ---- Configuration ----
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"
CONFIG_DIR="$HOME/.config"
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

function update_repository() {
  info "\nPulling latest changes from the repository..."
  git -C "$DOTFILES_DIR" pull || error "Failed to pull changes from the repository."
}

function update_symlinks() {
  info "\nUpdating symbolic links..."
  for item in "$DOTFILES_DIR/.config"/*;
  do
    local config_name
    config_name=$(basename "$item")
    local target_path="$CONFIG_DIR/$config_name"

    if [ ! -L "$target_path" ]; then
      info "Creating new symlink for $config_name"
      ln -sf "$item" "$target_path"
    fi
  done
}

function update_packages() {
  info "\nChecking for new packages to install..."
  if [ -f "$DOTFILES_DIR/packages.txt" ]; then
    yay -S --needed --noconfirm - < "$DOTFILES_DIR/packages.txt" || warn "Failed to install some packages."
  else
    warn "packages.txt not found, skipping package installation."
  fi
}

# ---- Main Execution ----
clear
info "=== HollowDots Refined Updater ==="
echo -e "This script will:"
echo -e "1. Pull the latest changes from the Git repository."
echo -e "2. Update the symbolic links for your dotfiles."
echo -e "3. Install any new packages from packages.txt."

read -p "Continue? (y/N) " -n 1 -r
[[ ! $REPLY =~ ^[Yy]$ ]] && exit 1

update_repository
update_symlinks
update_packages

info "\n=== Update Complete ==="
echo -e "Your dotfiles are now up to date."
