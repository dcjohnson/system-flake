#!/usr/bin/env bash 

parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1p1 -- mkpart ESP fat32 1MB 512MB
parted /dev/nvme0n1p2 -- mkpart root ext4 512MB -8GB
parted /dev/sda -- set 3 esp on



mkfs.bcachefs -L nixos /dev/nvme0n1p2
mkfs.fat -F 32 -n boot /dev/nvme0n1p1        # (for UEFI systems only)
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot                      # (for UEFI systems only)
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot # (for UEFI systems only)
#nixos-generate-config --root /mnt --flake 
#nano /mnt/etc/nixos/configuration.nix
#nixos-install # will need the flake parameter --flake
# reboot
