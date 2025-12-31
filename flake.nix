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

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
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
      silentSDDM,
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
            external-3rd-party-packages = {
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
        odroid-h4-schwab = odroid-h4.schwab-v1.default;
        odroid-h4-adguard = odroid-h4.adguard-v1.default;

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
            (
              (
                { inputs }:
                { config, pkgs, ... }:
                {
                  imports = [ inputs.silentSDDM.nixosModules.default ];
                  config = {
                    environment.systemPackages = [
                      pkgs.kdePackages.qtmultimedia
                      pkgs.kdePackages.qtvirtualkeyboard
                      pkgs.kdePackages.qtsvg
                    ];
                    programs = {
                      silentSDDM = {
                        enable = true;
                        theme = "catppuccin-latte";
                        # settings = { };
                      };
                    };
                  };
                }
              )
              { inherit inputs; }
            )

            ./modules/lenovo-thinkpad-t470/default.nix
          ];
        };
      };
    };
}
