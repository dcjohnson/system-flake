# system-flake
My System Flake

# Build iso 

```bash
nix build .#nixosConfigurations.nas-nixos.config.system.build.isoImage
```

# Build system config

```
nix build .#nixosConfigurations.nas-nixos.config.system.build.toplevel
```

# Activate new toplevel config after it builds 

```bash 
nix build .#nixosConfigurations.workstations.lenovo-thinkpad-t470.default.config.system.build.toplevel
sudo ./result/bin/switch-to-configuration boot
```

