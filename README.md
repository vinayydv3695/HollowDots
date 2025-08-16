# HollowDots

These are my personal dotfiles for Hyprland on Arch Linux. They are designed to be a complete and easy-to-use setup that is both beautiful and efficient.

## Screenshots

Here is a gallery of my desktop setup:

| | |
| :---: | :---: |
| **Main Desktop** | **Fastfetch** |
| ![Main Desktop](screenshots/main.png) | ![Fastfetch](screenshots/fastfetch.png) |
| **Neovim** | **Rofi** |
| ![Neovim](screenshots/neovim.png) | ![Rofi](screenshots/rofi.png) |
| **Yazi File Manager** | **Ghostty Terminal** |
| ![Yazi File Manager](screenshots/yazi.png) | ![Ghostty Terminal](screenshots/ghostty.png) |
| **Brave Browser** | **Hyprland Lock Screen** |
| ![Brave Browser](screenshots/bravebrowser.png) | ![Hyprland Lock Screen](screenshots/hyprlock_preview.png) |
| **Logout Options** | **SDDM Login Manager** |
| ![Logout Options](screenshots/logoutoptions.png) | ![SDDM Login Manager](screenshots/sddm.png) |

## Features

*   **A Beautiful and Consistent Design:** The entire setup is designed to be visually appealing and consistent, with a custom theme for all applications.
*   **Efficient Workflow:** The keybindings and scripts are designed to be as efficient as possible, allowing you to get your work done faster.
*   **Easy to Customize:** The dotfiles are designed to be easy to customize. You can change the theme, keybindings, and other settings to your liking.

## Installation

To install the dotfiles, follow these steps:

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/HollowDots.git
    ```

2.  **Run the installation script:**

    ```bash
    cd HollowDots
    ./.local/bin/install.sh
    ```

3.  **Reboot your system:**

    ```bash
    reboot
    ```

## Ansible

This repository uses Ansible to manage the dotfiles.

### Installation

1.  **Install Ansible:**

    Follow the official Ansible installation guide for your distribution. For Arch Linux, you can use the following command:

    ```bash
    sudo pacman -S ansible
    ```

### Usage

*   **Deploy the dotfiles:**

    ```bash
    ansible-playbook playbooks/main.yml --ask-become-pass
    ```

*   **Update the system:**

    ```bash
    ansible-playbook playbooks/update.yml --ask-become-pass
    ```

## Customization

To customize the dotfiles, you can create user-specific configuration files in the `~/.config` directory.

*   **Hyprland:** Create a `~/.config/hypr/userprefs.conf` file to add your own Hyprland settings.
*   **Kitty:** Create a `~/.config/kitty/userprefs.conf` file to add your own Kitty settings.

## Packages

The following packages are required for these dotfiles to work correctly:

```
hyprland
waybar
rofi-wayland
dunst
kitty
yazi
neovim
swaybg
swayidle
swaylock
playerctl
pamixer
ttf-jetbrains-mono
ttf-font-awesome
noto-fonts
fastfetch
ghostty
wlogout
blueman
udiskie
network-manager-applet
cliphist
```