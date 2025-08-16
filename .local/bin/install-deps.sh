#!/bin/bash
# install-deps.sh
sudo pacman -S --needed - < <(
  curl -s https://github.com/vinayydv3695/HollowDots/modules/dependecies/dependencies.txt
)
