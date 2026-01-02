# system-flake

My System Flake

# Delete old generations 

```bash
# To list generations
nix-env --profile /nix/var/nix/profiles/system --list-generations

# To keep just your current generation and the two older than it:
nix-env --profile … --delete-generations +3

# To remove all but your current generation:
nix-env --profile … --delete-generations old
```

# Build iso 

```bash
nix build .#nixosConfigurations.odroid-h4.nas-v1.default-installer.config.system.build.isoImage
```

# build and activate new system config 
```bash 
sudo nixos-rebuild switch --flake github:dcjohnson/system-flake#odroid-h4-schwab --refresh
```
The `--refresh` flag will fetch the latest flake


# Build system config

```
nix build .#nixosConfigurations.nas-nixos.config.system.build.toplevel
```

# Activate new toplevel config after it builds 

```bash 
nix build .#nixosConfigurations.workstations.lenovo-thinkpad-t470.default.config.system.build.toplevel
sudo ./result/bin/switch-to-configuration boot
```
# ZFS

https://nixos.wiki/wiki/ZFS
