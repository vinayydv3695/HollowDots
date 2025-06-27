#!/usr/bin/env bash
# HollowDots Automated Installer v2.0
set -eo pipefail

# ---- Configuration ----
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[1;33m'
COLOR_RESET='\033[0m'

# ---- Dependencies ----
CORE_PKGS=(
  hyprland waybar dunst kitty yazi neovim
  swaybg swayidle swaylock playerctl pamixer
  ttf-jetbrains-mono ttf-font-awesome noto-fonts
)

# Use rofi-wayland instead of regular rofi if on Wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  CORE_PKGS+=(rofi-wayland)
else
  CORE_PKGS+=(rofi)
fi

OPTIONAL_PKGS=(
  brave-bin ghostty-bin nvidia-utils
)

# ---- Functions ----
function error() {
  echo -e "${COLOR_RED}Error: $1${COLOR_RESET}" >&2
  exit 1
}

function warn() {
  echo -e "${COLOR_YELLOW}Warning: $1${COLOR_RESET}" >&2
}

function backup_existing() {
  echo -e "\n${COLOR_GREEN}Backing up existing configs to $BACKUP_DIR...${COLOR_RESET}"
  mkdir -p "$BACKUP_DIR"
  
  # Only backup directories that exist in the repo
  for dir in $(ls "$REPO_DIR" | grep -v 'install.sh'); do
    if [ -d "$CONFIG_DIR/$dir" ]; then
      mv -v "$CONFIG_DIR/$dir" "$BACKUP_DIR/" || warn "Failed to backup $dir"
    fi
  done
}

function install_dependencies() {
  echo -e "\n${COLOR_GREEN}Installing dependencies...${COLOR_RESET}"
  
  # First remove conflicting packages
  if pacman -Qi rofi-wayland &>/dev/null && [ "$XDG_SESSION_TYPE" != "wayland" ]; then
    sudo pacman -R --noconfirm rofi-wayland || warn "Failed to remove rofi-wayland"
  fi
  
  # Install core packages with individual error handling
  for pkg in "${CORE_PKGS[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
      sudo pacman -S --noconfirm "$pkg" || warn "Failed to install $pkg"
    else
      echo "$pkg is already installed"
    fi
  done
  
  # Optional AUR packages
  if command -v yay &>/dev/null; then
    echo -e "\n${COLOR_GREEN}Installing AUR packages...${COLOR_RESET}"
    for pkg in "${OPTIONAL_PKGS[@]}"; do
      yay -S --needed --noconfirm "$pkg" || warn "Failed to install $pkg (AUR)"
    done
  else
    warn "yay not found - skipping AUR packages"
  fi
}

function link_configs() {
  echo -e "\n${COLOR_GREEN}Linking configurations...${COLOR_RESET}"
  
  # Create .config if it doesn't exist
  mkdir -p "$CONFIG_DIR"
  
  for dir in $(ls "$REPO_DIR" | grep -v 'install.sh'); do
    target="$CONFIG_DIR/$(basename "$dir")"
    [ -e "$target" ] && rm -rf "$target"
    ln -sfv "$REPO_DIR/$dir" "$target" || error "Failed to link $dir"
  done
}

function post_install() {
  echo -e "\n${COLOR_GREEN}Running post-install steps...${COLOR_RESET}"
  
  # Font cache
  fc-cache -fv >/dev/null || warn "Failed to update font cache"
  
  # Default applications
  xdg-mime default brave.desktop x-scheme-handler/https 2>/dev/null || true
  xdg-mime default brave.desktop x-scheme-handler/http 2>/dev/null || true
  
  # Wayland portal
  if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    systemctl --user enable --now xdg-desktop-portal-hyprland 2>/dev/null || true
  fi
}

# ---- Main Execution ----
clear
echo -e "${COLOR_GREEN}Starting HollowDots Installation...${COLOR_RESET}"

# Verify not root
[ "$EUID" -eq 0 ] && error "Do not run as root!"

# Check Arch Linux
if ! grep -q "Arch Linux" /etc/os-release 2>/dev/null; then
  warn "This installer is optimized for Arch Linux"
  read -p "Continue anyway? [y/N] " -n 1 -r
  [[ ! $REPLY =~ ^[Yy]$ ]] && exit 1
fi

# Installation steps
backup_existing
install_dependencies
link_configs
post_install

# Completion message
echo -e "\n${COLOR_GREEN}Installation complete!${COLOR_RESET}"
echo -e "Backups saved to: $BACKUP_DIR"
echo -e "\nNext steps:"
echo "1. Restart your session"
echo "2. Configure your wallpaper with:"
echo "   $REPO_DIR/scripts/swwwallpaper.sh"
echo "3. Review keybindings in:"
echo "   $CONFIG_DIR/hypr/hyprland.conf"
