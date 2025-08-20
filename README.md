# HollowDots

These are my personal dotfiles and a tribute to Hollow knight and we are getting silksong lol . for Hyprland on Arch Linux. They are designed to be a complete and easy-to-use setup that is both beautiful and efficient. (Hornet Would be proud of me SHAWWWWWWW!!!)

---

## Workflow

Here is a short demo of my workflow:

<img src="screenshots/demo.gif" alt="Workflow Demo" width="800"/>

## Features

- **A Beautiful and Consistent Design:** The entire setup is designed to be visually appealing and consistent, with a custom theme for all applications.
- **Efficient Workflow:** The keybindings and scripts are designed to be as efficient as possible, allowing you to get your work done faster.
- **Easy to Customize:** The dotfiles are designed to be easy to customize. You can change the theme, keybindings, and other settings to your liking.

## Key Applications

This setup configures and themes a range of applications to ensure a cohesive experience:

- **Window Manager**: `hyprland`
- **Bar**: `waybar`
- **Launcher**: `rofi-wayland`
- **Notification Daemon**: `dunst`
- **Terminals**: `kitty` & `ghostty`
- **File Manager**: `yazi`
- **Editor**: `neovim`
- **Utilities**: `swaybg`, `swayidle`, `hyprlock`, `wlogout`, `cliphist`, `playerctl`
- **System**: `fastfetch`, `blueman`, `network-manager-applet`, `udiskie`

## Core Keybindings

The main modifier key is the **Super** (Windows) key, represented as `$mainMod`.

| Keybinding                 | Action                           |
| :------------------------- | :------------------------------- |
| `$mainMod + C`             | Open Terminal (Kitty)            |
| `$mainMod + E`             | Open File Manager (Dolphin)      |
| `$mainMod + F`             | Open Browser (Brave)             |
| `$mainMod + Q`             | Close focused window             |
| `$mainMod + L`             | Lock screen                      |
| `$mainMod + Backspace`     | Show logout menu (wlogout)       |
| `$mainMod + W`             | Toggle floating window           |
| `Alt + Return`             | Toggle fullscreen                |
| `$mainMod + A`             | Open application launcher (Rofi) |
| `$mainMod + Tab`           | Show window switcher (Rofi)      |
| `$mainMod + [1-9]`         | Switch to workspace [1-9]        |
| `$mainMod + Shift + [1-9]` | Move window to workspace [1-9]   |
| `$mainMod + P`             | Take a partial screenshot        |
| `$mainMod + Shift + T`     | Select theme                     |
| `$mainMod + Shift + Z`     | Select wallpaper                 |
| `$mainMod + V`             | Show clipboard history           |

## A Glimpse of HollowDots

<details>
<summary>Click to expand</summary>

<table>
  <tr>
    <td align="center">
      <a href="screenshots/main.png">
        <img src="screenshots/main.png" alt="Main Desktop" width="800"/>
      </a>
      <br />
      <sub style="font-size: 22px;"><b>Main Desktop:</b> A clean and organized desktop with a custom wallpaper and a Waybar panel.</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/fastfetch.png">
        <img src="screenshots/fastfetch.png" alt="Fastfetch" width="800"/>
      </a>
      <br />
      <sub style="font-size: 22px;"><b>Fastfetch:</b> A customized fastfetch output with a theme that matches the overall aesthetic.</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/rofi.png">
        <img src="screenshots/rofi.png" alt="Rofi" width="800"/>
      </a>
      <br />
      <sub style="font-size: 22px;"><b>Rofi:</b> A versatile application launcher with a custom theme and layout.</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/neovim.png">
        <img src="screenshots/neovim.png" alt="Neovim" width="800"/>
      </a>
      <br />
      <sub style="font-size: 22px;"><b>Neovim:</b> A highly customized Neovim setup with a custom theme, plugins, and a status line.</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/yazi.png">
        <img src="screenshots/yazi.png" alt="Yazi File Manager" width="800"/>
      </a>
      <br />
      <sub style="font-size: 22px;"><b>Yazi File Manager:</b> A terminal-based file manager with a custom theme and keybindings.</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/ghostty.png">
        <img src="screenshots/ghostty.png" alt="Ghostty Terminal" width="800"/>
      </a>
      <br />
      <sub style="font-size: 22px;"><b>Ghostty Terminal:</b> A modern, GPU-accelerated terminal emulator with a custom theme.</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/bravebrowser.png">
        <img src="screenshots/bravebrowser.png" alt="Brave Browser" width="800"/>
      </a>
      <br />
      <sub style="font-size: 22px;"><b>Brave Browser:</b> A privacy-focused web browser with a custom theme.</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/hyprlock_preview.png">
        <img src="screenshots/hyprlock_preview.png" alt="Hyprland Lock Screen" width="800"/>
      </a>
      <br />
      <sub style="font-size: 22px;"><b>Hyprland Lock Screen:</b> A beautiful and secure lock screen with a custom theme.</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/logoutoptions.png">
        <img src="screenshots/logoutoptions.png" alt="Logout Options" width="800"/>
      </a>
      <br />
      <sub style="font-size: 22px;"><b>Logout Options:</b> A clean and simple logout menu with options to shut down, restart, and sleep.</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/sddm.png">
        <img src="screenshots/sddm.png" alt="SDDM Login Manager" width="800"/>
      </a>
      <br />
      <sub style="font-size: 22px;"><b>SDDM Login Manager:</b> A custom-themed SDDM login manager to complete the experience.</sub>
    </td>
  </tr>
</table>

</details>

## Ansible for Automation

This repository uses Ansible to automate the setup and management of the dotfiles on Arch Linux.

### Prerequisites

1.  **Install Ansible:** Follow the official Ansible installation guide for your distribution. For Arch Linux, you can use:
    ```bash
    sudo pacman -S ansible
    ```
2.  **Clone the repository:**
    ```bash
    git clone https://github.com/Vinayydv3695/HollowDots.git
    cd HollowDots
    ```

### Playbooks

The following playbooks are available in the `Ansible/playbooks/` directory:

- **`main.yml`**: This is the main playbook that sets up the entire system. It installs all the necessary packages, copies the dotfiles, and configures the system settings.
- **`deploy.yml`**: This playbook deploys the dotfiles and installs all the packages defined in `group_vars/all.yml`.
- **`update.yml`**: This playbook updates system packages (pacman and AUR) and synchronizes the dotfiles.

### Usage

To run a playbook, use the `ansible-playbook` command. For example:

- **To run the main setup playbook:**
  ```bash
  ansible-playbook Ansible/playbooks/main.yml --ask-become-pass
  ```
- **To deploy the dotfiles and packages:**
  ```bash
  ansible-playbook Ansible/playbooks/deploy.yml --ask-become-pass
  ```
- **To update the system and dotfiles:**
  ```bash
  ansible-playbook Ansible/playbooks/update.yml --ask-become-pass
  ```
