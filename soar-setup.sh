#!/usr/bin/env bash

set -euo pipefail

read -r -p "Do you want to install/update Soar ( Distro Independant Appimage manager ) ? [y/n] " answer

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


echo "Installing Soar..."

if ! command -v soar >/dev/null 2>&1; then
  curl -fsSL \
    "https://raw.githubusercontent.com/pkgforge/soar/main/install.sh" |
    sh
else
  echo "Soar is already installed. An Update will be proceed."
    soar update
fi

# Add the directory where the Soar executable is installed
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# Add Soar's installed application directory
export PATH="$HOME/.local/share/soar/bin:$PATH"

# Check that Soar is available
if ! command -v soar >/dev/null 2>&1; then
  echo "Error: Soar was installed but could not be found in PATH."
  echo "Restart your terminal and try again."
  exit 1
fi

read -r -p "Do you want to list all the packages of Soar ? [y/n] " list

case "$asked6" in
  [Yy]|[Yy][Ee][Ss])
    echo " Listing all available packages "
    soar list
    ;;
  [Nn]|[Nn][Oo])
    echo
    ;;
esac


read -r -p "Do you want to install any appimage ? [y/n] " answer2

case "$answer2" in
  [Yy]|[Yy][Ee][Ss])
    ;;
  [Nn]|[Nn][Oo])
    echo " Installation complete. "
    exit 0
    ;;

  *)
    echo "Invalid answer. Installation cancelled."
    exit 1
    ;;
esac

read -r -p "List all the appimage you want like the following -> (appimage1 appimage2) : " listedapp


packages_soar=($askedapp)

echo "The following packages will be installed using soar:"
printf ' - %s\n' "${packages_soar[@]}"
echo

read -r -p "Continue with the installation? [y/n] " answer3
printf ' - %s\n' "${packages_soar[@]}"

case "$answer3" in
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

echo "Synchronizing Soar repositories..."

soar sync

echo "Installing applications with Soar..."

soar install "${packages_soar[@]}"

echo
echo "Installation complete."
