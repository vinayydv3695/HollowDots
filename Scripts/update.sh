#!/usr/bin/env bash
# HollowDots Intelligent Updater
set -eo pipefail

# ---- Configuration ----
CONFIG_DIR="$HOME/.config"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config_update_backup_$(date +%Y%m%d_%H%M%S)"
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

function backup_changed() {
  echo -e "\n${COLOR_GREEN}Backing up modified configs...${COLOR_RESET}"
  mkdir -p "$BACKUP_DIR"
  
  # Find and backup only files that differ from repo
  while IFS= read -r -d '' file; do
    rel_path="${file#$REPO_DIR/}"
    target_file="$CONFIG_DIR/$rel_path"
    
    if [ -e "$target_file" ] && ! cmp -s "$file" "$target_file"; then
      mkdir -p "$(dirname "$BACKUP_DIR/$rel_path")"
      cp -v "$target_file" "$BACKUP_DIR/$rel_path" || warn "Failed to backup $rel_path"
    fi
  done < <(find "$REPO_DIR" -type f -not -path '*/\.git/*' -print0)
}

function update_configs() {
  echo -e "\n${COLOR_GREEN}Updating configurations...${COLOR_RESET}"
  
  # Preserve user-modified files while updating others
  rsync -av --progress --ignore-existing \
    --exclude='*.local' --exclude='*.bak' \
    "$REPO_DIR/" "$CONFIG_DIR/" || error "Update failed"
  
  # Make scripts executable
  find "$CONFIG_DIR" -type f -name "*.sh" -exec chmod +x {} \;
}

function update_dependencies() {
  echo -e "\n${COLOR_GREEN}Checking for package updates...${COLOR_RESET}"
  
  if command -v yay &>/dev/null; then
    yay -Syu --needed --noconfirm \
      hyprland waybar rofi-wayland dunst kitty yazi \
      fastfetch ghostty wlogout || warn "Some packages failed to update"
  else
    sudo pacman -Syu --needed --noconfirm \
      hyprland waybar rofi-wayland dunst kitty yazi \
      fastfetch ghostty wlogout || warn "Some packages failed to update"
  fi
}

# ---- Main Execution ----
clear
echo -e "${COLOR_GREEN}=== HollowDots Updater ===${COLOR_RESET}"
echo -e "This will:"
echo -e "1. Backup only modified config files"
echo -e "2. Update configurations from repository"
echo -e "3. Update system packages"
echo -e "${COLOR_YELLOW}Note: Your custom changes will be preserved${COLOR_RESET}"

read -p "Continue? [Y/n] " -n 1 -r
echo
[[ $REPLY =~ ^[Nn]$ ]] && exit 0

backup_changed
update_configs
update_dependencies

echo -e "\n${COLOR_GREEN}=== Update Complete ===${COLOR_RESET}"
echo -e "Backup of modified files saved to:"
echo -e "$BACKUP_DIR"
echo -e "\nNext steps:"
echo -e "1. Review any merge conflicts in:"
echo -e "   $CONFIG_DIR"
echo -e "2. Restart Hyprland to apply changes"
