{
  description = "My system flake";
  inputs = {
    schwab-auto-trader.url = "github:dcjohnson/schwab-auto-trader?ref=feature/no-locks-in-oauthmanager";
    schwab-auto-trader.flake = false;

    naersk.url = "github:nix-community/naersk/master";
    naersk.flake = false;

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      schwab-auto-trader,
      nixpkgs,
      disko,
      naersk,
    }@inputs:
    let
      system = "x86_64-linux";
      dpkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        hostPlatform = system;
        overlays = [
          (final: prev: {
            djohnson-packages = {
              installers = import ./pkgs/packages.nix {
                pkgs = final;
              };
              schwab-auto-trader = final.callPackage "${inputs.schwab-auto-trader}/package.nix" {
                pkgs = final;
                inherit naersk;
                src = inputs.schwab-auto-trader;
              };
            };
          })
        ];
      };

    in
    {
      formatter.${system} = dpkgs.nixfmt-tree;

      diskoConfigurations = {
        nvme = import ./modules/odroid-h4/disko-config.nix;
      };

      nixosConfigurations = rec {
        odroid-h4-nas = odroid-h4.nas-v1.default;
        odroid-h4-schwab = odroid-h4.schwab-v1.default;
        odroid-h4 = {
          schwab-v1 = {
            default = nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit disko;
              };
              pkgs = dpkgs;
              modules = [
                ./modules/odroid-h4/schwab-nixos/default.nix
              ];
            };

            default-installer = nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit disko;
              };
              pkgs = dpkgs;
              modules = [
                ./modules/odroid-h4/schwab-nixos/default-installer.nix
              ];
            };

          };
          nas-v1 = {
            default = nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit disko;
              };
              pkgs = dpkgs;
              modules = [
                ./modules/odroid-h4/nas-nixos/default.nix
              ];
            };
            default-installer = nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit disko;
              };
              pkgs = dpkgs;
              modules = [
                ./modules/odroid-h4/nas-nixos/default-installer.nix
              ];
            };
          };
        };

        system76-thelio-inspired = nixpkgs.lib.nixosSystem {
          pkgs = dpkgs;
          modules = [
            ./modules/system76-thelio-inspired/configuration.nix
          ];
        };

        lenovo-thinkpad-t470 = nixpkgs.lib.nixosSystem {
          pkgs = dpkgs;
          modules = [
            ./modules/lenovo-thinkpad-t470/default.nix
          ];
        };
      };
    };
}
