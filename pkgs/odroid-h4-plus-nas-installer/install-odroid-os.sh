#!/usr/bin/env bash 

nix run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake 'github:dcjohnson/system-flake#odroid-h4-nas' --disk nvme0n1 /dev/nvme0n1 

mount /dev/nvme0n1p2 /mnt

nixos-enter --root /mnt -c 'passwd root'
nixos-enter --root /mnt -c 'passwd nas'

umount /dev/nvme0n1p2


