#!/bin/bash

# Update system
sudo pacman -Syu --no-confirm

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
    fastfetch
    grim
    imagemagick
    noto-fonts-emoji
    otf-font-awesome
    playerctl
    rofimoji
    rofi-wayland
    slurp
    thunar 
    htop
    thunar-volman 
    tumbler
    ffmpegthumbnailer 
    thunar-archive-plugin
    xarchiver
    wf-recorder
    noto-fonts
    wlsunset
    git
    nvim
    wget
    curl
    starship
    sway
    swaybg
    ly
    swayidle
    swaylock
    swaync
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd
    waybar
    wl-clipboard
    zsh
    stow
    gnome-calculator
    gnome-decibels
    loupe
    evince
    totem
    zip
    unzip
)

sudo pacman -S --needed --noconfirm "${pacman_packages[@]}"

## AUR
aur_packages=(
    wttrbar
    google-chrome
    matugen-bin
    wallust
)

yay -S --needed --noconfirm "${aur_packages[@]}"

# Set up dotfiles
cd ~
git clone --depth=1 https://github.com/aceydot/minimal-sway
git clone --depth=1 https://github.com/aceydot/material-sway
cd material-sway
stow .

# Set zsh
ZSHRC="$HOME/.zshrc"
touch "$ZSHRC"

chsh -s /usr/bin/zsh
## History
if ! grep -q 'HISTSIZE' "$ZSHRC"; then
  cat >> "$ZSHRC" <<'EOF'

HISTSIZE=100000
SAVEHIST=100000
setopt inc_append_history
setopt share_history
EOF
fi
## Set starship
if ! grep -qxF 'eval "$(starship init zsh)"' "$ZSHRC"; then
  printf '\n%s\n' 'eval "$(starship init zsh)"' >> "$ZSHRC"
fi

# Enable ly
sudo systemctl enable ly.service
