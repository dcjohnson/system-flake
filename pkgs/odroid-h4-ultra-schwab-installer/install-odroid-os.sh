#!/usr/bin/env bash 

nix run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake 'github:dcjohnson/system-flake#odroid-h4-schwab' --disk nvme0n1 /dev/nvme0n1

mount /dev/nvme0n1p2 /mnt

echo 'Set root password'
nixos-enter --root /mnt -c 'passwd root'
echo 'Set trader password'
nixos-enter --root /mnt -c 'passwd trader'

umount /dev/nvme0n1p2
