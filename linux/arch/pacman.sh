#!/usr/bin/env bash

set -euo pipefail

# Check that the script is running on an Arch-based system
if ! command -v pacman >/dev/null 2>&1; then
  echo "Error: pacman was not found."
  echo "This script is intended for Arch-based distributions."
  exit 1
fi

# Check that sudo is available
if ! command -v sudo >/dev/null 2>&1; then
  echo "Error: sudo is required."
  exit 1
fi

packages=(
  ufw
  fish
  curl
  fuse
  vim
  swayimg
  tealdeer
  fzf
  onlyoffice
  proton-vpn-gtk-app
  clamtk
  lact
  webcord
  steam
  flatpak
)


echo "The following packages will be installed:"
printf ' - %s\n' "${packages[@]}"
echo

read -r -p "Continue with the installation? [y/n] " answer

case "$answer" in
  [Yy]|[Yy][Ee][Ss])
    ;;
  [Nn]|[Nn][Oo])
    echo "Installation cancelled."
    exit 0
    ;;
  *)
    echo "Invalid answer. Installation cancelled."
    exit 1
    ;;
esac

echo "Updating the system..."

sudo pacman -Syu

echo "Installing packages..."

sudo pacman -S --needed "${packages[@]}"


echo
echo "Installation complete."
