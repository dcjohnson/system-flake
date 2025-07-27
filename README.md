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
