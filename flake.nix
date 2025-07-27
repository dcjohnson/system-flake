{
  description = "My system flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
     disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs =
    { self, nixpkgs, disko }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [ ];
      };
    in
    {
      formatter.${system} = pkgs.nixfmt-tree;
      nixosConfigurations = {
        nas-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit pkgs system;
          };
          modules = [
	  disko.nixosModules.disko
            (
              { pkgs, modulesPath, ... }:
              {
                imports = [
                  (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
                ];
                environment.systemPackages = [ pkgs.neovim ];
              }
            )
            ./configurations/nas-nixos/configuration.nix
	    
	    ./configurations/nas-nixos/disko-config.nix 
	    {
	      _module.args.disks = [ "/dev/nvme0n1" ];
            }
	    ];
        };
        djohnson-thinkpad-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit pkgs;
            inherit system;
          };
          modules = [
            ./configurations/djohnson-thinkpad-nixos/configuration.nix
          ];
        };
      };
    };
}
