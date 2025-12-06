#! /usr/bin/env bash
#
# This script installs the keys necessary to install and decrypt secrets, and
# installs the actual configuration. Run this script once after booting into a
# fresh system (after nixos-install & reboot).
# This script is run as root; there are no other users yet.

set -euo pipefail

main() {
  local MOUNTPOINT
  local DEVICE_NAME
  local device
  local system

  readonly MOUNTPOINT="/root/tmp-external-drive"
  readonly DEVICE_NAME="external-drive"

  echo "Make sure you have an internet connection. Ctrl+C if you forgot to nmtui."
  read -p "Plug in the external drive now. Press enter when ready."

  # Read the external drive name:
  echo "Disks:"
  lsblk
  while true; do
    read -p "Which partition to mount? (e.g. sda1): " device
    if [[ -e "/dev/$device" ]]; then
      break
    fi
    echo "Device /dev/$device does not exist, try again."
  done

  # Open and mount the external drive:
  mkdir "$MOUNTPOINT"
  cryptsetup luksOpen "/dev/$device" "$DEVICE_NAME"
  mount "/dev/mapper/$DEVICE_NAME" "$MOUNTPOINT"

  # Read the system name:
  echo "Systems:"
  find "$MOUNTPOINT/var/lib/sops" -mindepth 1 -maxdepth 1 -type d -printf "%f\n"
  while true; do
    read -p "Which system to install? " system
    if [[ -d "$MOUNTPOINT/var/lib/sops/$system" ]]; then
      break
    fi
    echo "System $system does not exist, try again."
  done

  # Install pre-generated SSH keys:
  mkdir /root/.ssh
  cp "$MOUNTPOINT/id_ed25519" /root/.ssh
  chmod 600 /root/.ssh/id_ed25519

  # Install SOPS server keys:
  cp -r "$MOUNTPOINT/var/lib/sops/$system" /var/lib/sops

  # Unmount and close the external drive:
  umount "$MOUNTPOINT"
  cryptsetup luksClose "$DEVICE_NAME"
  rmdir "$MOUNTPOINT"

  echo "You can now unplug the external drive."

  # Clone the config repo & install the config.
  git clone --depth 1 git@github.com:mikkopitkanen222/nixos-config.git
  nixos-rebuild boot -j auto --flake ./nixos-config#$system
  echo "New system built successfully and set as the default boot option!"

  if [[ ! -d /home/mp ]]; then
    echo "User directories may not have been created yet, so running 'switch' as well."
    echo "The system may freeze, crash, or restart itself, but just reboot and you'll boot into your config!"
    nixos-rebuild switch -j auto --flake ./nixos-config#$system
    echo -n "Switch successful! "
  fi

  echo "Reboot and you're good to go!"
}

main
