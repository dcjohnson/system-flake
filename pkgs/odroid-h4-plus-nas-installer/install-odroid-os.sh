#!/usr/bin/env bash 

parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart ESP fat32 1MB 512MB
parted /dev/nvme0n1 -- mkpart root btrfs 512MB 100%
parted /dev/nvme0n1 -- set 1 esp on

mkfs.fat -F 32 -n boot /dev/nvme0n1p1       
mkfs.btrfs -f -L nixos /dev/nvme0n1p2

sleep 5

mkdir /mnt
mount /dev/disk/by-label/nixos /mnt

mkdir -p /mnt/boot                   
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

nixos-generate-config --root /mnt --flake 
nix build github:dcjohnson/system-flake#nixosConfigurations.odroid-h4.nas-v1.default.config.system.build.toplevel
nixos-installer --root /mnt --system ./result


# reboot
