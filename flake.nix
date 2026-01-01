{
  description = "My system flake";
  inputs = {
    schwab-auto-trader.url = "github:dcjohnson/schwab-auto-trader?ref=main";
    schwab-auto-trader.flake = false;

    naersk.url = "github:nix-community/naersk/master";
    naersk.flake = false;

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      schwab-auto-trader,
      nixpkgs,
      disko,
      naersk,
      rose-pine-hyprcursor,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      dpkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "mbedtls-2.28.10" ];
        };
        hostPlatform = system;
        overlays = [
          (final: prev: {
            flake-packages = import ./pkgs/packages.nix {
              pkgs = final;
            };
            external-packages = {
              schwab-auto-trader = final.callPackage "${inputs.schwab-auto-trader}/package.nix" {
                pkgs = final;
                inherit naersk;
                src = inputs.schwab-auto-trader;
              };
              rose-pine-hyprcursor = rose-pine-hyprcursor.packages.${system}.default;
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

      homeConfigurations."dcj@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = dpkgs;

        modules = [
          ./modules/home-manager/dcj.nix
        ];
      };

      nixosConfigurations = rec {
        odroid-h4-nas = odroid-h4.nas-v1.default;
        odroid-h4-nas-installer = odroid-h4.nas-v1.installer;
        odroid-h4-schwab = odroid-h4.schwab-v1.default;
        odroid-h4-schwab-installer = odroid-h4.schwab-v1.installer;
        odroid-h4-adguard = odroid-h4.adguard-v1.default;
        odroid-h4-adguard-installer = odroid-h4.adguard-v1.installer;

        odroid-h4 = {
          adguard-v1 = {
            default = nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit disko;
              };
              pkgs = dpkgs;
              modules = [
                ./modules/odroid-h4/adguard-server-nixos/default.nix
              ];
            };

            installer = nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit disko;
              };
              pkgs = dpkgs;
              modules = [
                ./modules/odroid-h4/adguard-server-nixos/default-installer.nix
              ];
            };
          };
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

            installer = nixpkgs.lib.nixosSystem {
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
            installer = nixpkgs.lib.nixosSystem {
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
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./modules/system76-thelio-inspired/configuration.nix
          ];
        };

        lenovo-thinkpad-t470 = nixpkgs.lib.nixosSystem {
          pkgs = dpkgs;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./modules/lenovo-thinkpad-t470/default.nix
          ];
        };
      };
    };
}
