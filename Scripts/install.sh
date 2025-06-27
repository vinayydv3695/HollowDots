#!/usr/bin/env bash
# HollowDots Full Config Replacement Installer
set -eo pipefail

# ---- Configuration ----
CONFIG_SOURCE="$HOME/Personal/Dotfiles/HollowDots"  # Change this to your repo path
CONFIG_TARGET="$HOME/.config"
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[1;33m'
COLOR_RESET='\033[0m'

# ---- Dependencies ----
CORE_PKGS=(
  hyprland waybar rofi-wayland dunst kitty yazi neovim
  swaybg swayidle swaylock playerctl pamixer
  ttf-jetbrains-mono ttf-font-awesome noto-fonts
  fastfetch ghostty wlogout
)

# ---- Functions ----
function error() {
  echo -e "${COLOR_RED}Error: $1${COLOR_RESET}" >&2
  exit 1
}

function warn() {
  echo -e "${COLOR_YELLOW}Warning: $1${COLOR_RESET}" >&2
}

function backup_configs() {
  echo -e "\n${COLOR_GREEN}Creating full backup at $BACKUP_DIR...${COLOR_RESET}"
  mkdir -p "$BACKUP_DIR"
  
  # Backup entire .config if it exists
  if [ -d "$CONFIG_TARGET" ]; then
    rsync -a "$CONFIG_TARGET/" "$BACKUP_DIR/" || error "Backup failed!"
    echo "Backup completed successfully"
  else
    warn "No existing .config directory found"
  fi
}

function wipe_existing_configs() {
  echo -e "\n${COLOR_GREEN}Clearing existing configs...${COLOR_RESET}"
  
  # Remove all existing configs
  if [ -d "$CONFIG_TARGET" ]; then
    find "$CONFIG_TARGET" -mindepth 1 -delete || warn "Failed to delete some configs"
  else
    mkdir -p "$CONFIG_TARGET"
  fi
}

function install_dependencies() {
  echo -e "\n${COLOR_GREEN}Installing required packages...${COLOR_RESET}"
  
  # Check for yay (AUR helper)
  if ! command -v yay &>/dev/null; then
    warn "yay not found - installing..."
    sudo pacman -S --needed --noconfirm git base-devel || error "Failed to install build tools"
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin && makepkg -si --noconfirm || error "Failed to install yay"
    cd "$CONFIG_SOURCE"
  fi

  # Install all packages
  yay -S --needed --noconfirm "${CORE_PKGS[@]}" || error "Failed to install packages"
}

function deploy_configs() {
  echo -e "\n${COLOR_GREEN}Deploying HollowDots configuration...${COLOR_RESET}"
  
  # Copy all configs from repo to .config
  rsync -av --progress "$CONFIG_SOURCE/" "$CONFIG_TARGET/" || error "Config deployment failed"
  
  # Fix permissions
  find "$CONFIG_TARGET" -type d -exec chmod 755 {} \;
  find "$CONFIG_TARGET" -type f -exec chmod 644 {} \;
  
  # Special permissions for scripts
  chmod +x "$CONFIG_TARGET/hypr/scripts/"* || warn "Failed to make scripts executable"
}

function post_install() {
  echo -e "\n${COLOR_GREEN}Running post-install setup...${COLOR_RESET}"
  
  # Font cache
  fc-cache -fv >/dev/null || warn "Font cache update failed"
  
  # GTK theme symlinks
  ln -sf "$CONFIG_TARGET/gtk-4.0" "$CONFIG_TARGET/gtk-4.0/gtk-4.0" || true
  
  # Default applications
  xdg-mime default brave.desktop x-scheme-handler/https
  xdg-mime default brave.desktop x-scheme-handler/http
  xdg-mime default dolphin.desktop inode/directory
  
  # Systemd services
  systemctl --user enable --now xdg-desktop-portal-hyprland 2>/dev/null || true
}

# ---- Main Execution ----
clear
echo -e "${COLOR_GREEN}=== HollowDots Nuclear Deployment ===${COLOR_RESET}"
echo -e "This will:"
echo -e "1. Backup existing .config to $BACKUP_DIR"
echo -e "2. Remove ALL existing configs"
echo -e "3. Install required packages"
echo -e "4. Deploy complete HollowDots configuration"
echo -e "${COLOR_RED}Warning: This will completely replace your current .config!${COLOR_RESET}"

read -p "Continue? (y/N) " -n 1 -r
[[ ! $REPLY =~ ^[Yy]$ ]] && exit 1

# Execution sequence
backup_configs
wipe_existing_configs
install_dependencies
deploy_configs
post_install

# Completion
echo -e "\n${COLOR_GREEN}=== Installation Complete ===${COLOR_RESET}"
echo -e "Your original configs were saved to:"
echo -e "$BACKUP_DIR"
echo -e "\nNext steps:"
echo -e "1. Restart your session (Alt+Ctrl+Backspace)"
echo -e "2. Set your wallpaper:"
echo -e "   $CONFIG_TARGET/hypr/scripts/swwwallpaper.sh"
echo -e "3. Configure any remaining personal preferences"
