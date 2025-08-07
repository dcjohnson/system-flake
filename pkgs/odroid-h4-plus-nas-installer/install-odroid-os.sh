#!/usr/bin/env bash 

parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart ESP fat32 1MB 512MB
parted /dev/nvme0n1 -- mkpart root btrfs 512MB 100%
parted /dev/nvme0n1 -- set 1 esp on



mkfs.fat -F 32 -n boot /dev/nvme0n1p1       
mkfs.btrfs -f -L nixos /dev/nvme0n1p2
mount /dev/disk/by-label/nixos /mnt
mkdir /boot                   
mount -o umask=077 /dev/disk/by-label/boot /boot
nixos-generate-config --root /mnt --flake 
nixos-install --flake github:dcjohnson/system-flake#odroid-h4-nas-v1-default

# possibly modify fstab as well after this. 
echo "Should you modify the fstab?!"

# reboot
