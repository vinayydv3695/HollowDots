# HollowDots

These are my personal dotfiles for Hyprland on Arch Linux. They are designed to be a complete and easy-to-use setup that is both beautiful and efficient.

---

## Screenshots

<details>
<summary>Click to expand</summary>

### Here is a gallery of my desktop setup:

<table>
  <tr>
    <td align="center">
      <a href="screenshots/main.png">
        <img src="screenshots/main.png" alt="Main Desktop" width="400"/>
      </a>
      <br />
      <sub><b>Main Desktop</b></sub>
    </td>
    <td align="center">
      <a href="screenshots/fastfetch.png">
        <img src="screenshots/fastfetch.png" alt="Fastfetch" width="400"/>
      </a>
      <br />
      <sub><b>Fastfetch</b></sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/neovim.png">
        <img src="screenshots/neovim.png" alt="Neovim" width="400"/>
      </a>
      <br />
      <sub><b>Neovim</b></sub>
    </td>
    <td align="center">
      <a href="screenshots/rofi.png">
        <img src="screenshots/rofi.png" alt="Rofi" width="400"/>
      </a>
      <br />
      <sub><b>Rofi</b></sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/yazi.png">
        <img src="screenshots/yazi.png" alt="Yazi File Manager" width="400"/>
      </a>
      <br />
      <sub><b>Yazi File Manager</b></sub>
    </td>
    <td align="center">
      <a href="screenshots/ghostty.png">
        <img src="screenshots/ghostty.png" alt="Ghostty Terminal" width="400"/>
      </a>
      <br />
      <sub><b>Ghostty Terminal</b></sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/bravebrowser.png">
        <img src="screenshots/bravebrowser.png" alt="Brave Browser" width="400"/>
      </a>
      <br />
      <sub><b>Brave Browser</b></sub>
    </td>
    <td align="center">
      <a href="screenshots/hyprlock_preview.png">
        <img src="screenshots/hyprlock_preview.png" alt="Hyprland Lock Screen" width="400"/>
      </a>
      <br />
      <sub><b>Hyprland Lock Screen</b></sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="screenshots/logoutoptions.png">
        <img src="screenshots/logoutoptions.png" alt="Logout Options" width="400"/>
      </a>
      <br />
      <sub><b>Logout Options</b></sub>
    </td>
    <td align="center">
      <a href="screenshots/sddm.png">
        <img src="screenshots/sddm.png" alt="SDDM Login Manager" width="400"/>
      </a>
      <br />
      <sub><b>SDDM Login Manager</b></sub>
    </td>
  </tr>
</table>

</details>

## Features

- **A Beautiful and Consistent Design:** The entire setup is designed to be visually appealing and consistent, with a custom theme for all applications.
- **Efficient Workflow:** The keybindings and scripts are designed to be as efficient as possible, allowing you to get your work done faster.
- **Easy to Customize:** The dotfiles are designed to be easy to customize. You can change the theme, keybindings, and other settings to your liking.

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

The following playbooks are available in the `playbooks/` directory:

- **`main.yml`**: This is the main playbook that sets up the entire system. It installs all the necessary packages, copies the dotfiles, and configures the system settings.
- **`update.yml`**: This playbook updates the system packages.
- **`deploy.yml`**: This playbook deploys the dotfiles to the local machine.
- **`ssh-setup.yml`**: This playbook helps in setting up SSH keys for secure remote management.

### Usage

To run a playbook, use the `ansible-playbook` command. For example, to run the main setup playbook:

```bash
ansible-playbook playbooks/main.yml --ask-become-pass
```

## Customization

To customize the dotfiles, you can create user-specific configuration files in the `~/.config` directory.

- **Hyprland:** Create a `~/.config/hypr/userprefs.conf` file to add your own Hyprland settings.
- **Kitty:** Create a `~/.config/kitty/userprefs.conf` file to add your own Kitty settings.
