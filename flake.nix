{
  description = "My system flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
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
            djohnson-packages = import ./pkgs/packages.nix {
              pkgs = final;
            };
          })
        ];
      };

    in
    {
      formatter.${system} = dpkgs.nixfmt-tree;
      nixosConfigurations = {
        odroid-h4 = {
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

	workstations = {
        lenovo-thinkpad-t470 = {
	default = nixpkgs.lib.nixosSystem {
          pkgs = dpkgs;
          modules = [
            ./modules/djohnson-thinkpad-nixos/default.nix
          ];
        };
      }; 
      };
      };
    };
}
