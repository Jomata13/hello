#!/bin/bash

# Update system
sudo pacman -Syu --noconfirm

# Install yay
git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
  cd /tmp/yay-bin
  makepkg -si --noconfirm
  cd -
  rm -rf /tmp/yay-bin

# Install packages
## Pacman
pacman_packages=(
    alacritty
    curl
    decibels
    evince
    fastfetch
    ffmpegthumbnailer 
    git
    gnome-calculator
    grim
    htop
    imagemagick
    loupe
    ly
    noto-fonts
    noto-fonts-emoji
    nvim
    otf-font-awesome
    playerctl
    rofi-wayland
    rofimoji
    slurp
    starship
    stow
    sway
    swayidle
    swaylock
    swaync
    swww
    thunar 
    thunar-archive-plugin
    thunar-volman 
    totem
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd
    tumbler
    unzip
    waybar
    wf-recorder
    wget
    wlsunset
    xarchiver
    xclip
    zip
    zsh
)

sudo pacman -Sy --needed --noconfirm "${pacman_packages[@]}"

## AUR
aur_packages=(
    clipton-git
    google-chrome
    matugen-bin
    wallust
    wttrbar
)

yay -Sy --needed --noconfirm "${aur_packages[@]}"

# Set up dotfiles
mkdir -p ~/.config
cd ~
git clone --depth=1 https://github.com/aceydot/material-sway
git clone --depth=1 https://github.com/aceydot/minimal-sway
cd material-sway
chmod +x .config/rofi/scripts/*.sh
stow .
cd ~
cd minimal-sway
chmod +x .config/rofi/scripts/*.sh

# Set zsh
chsh -s /usr/bin/zsh

# Set up git
git config --global user.email "aceydot@tuta.io"
git config --global user.name "aceydot"
git config --global credential.helper "cache --timeout=3600"

# Set up clipboard
systemctl --user enable --now clipton

# Enable ly
sudo systemctl enable ly
