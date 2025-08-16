# My Automated Hyprland Arch Install Ansible Playbook

# For Fresh Install - 

```zsh
chmod +x install
./install 
```

# For just ssh keys - 

```zsh
ansible-playbook ./standalones/ssh-setup.yml --ask-vault-pass
```