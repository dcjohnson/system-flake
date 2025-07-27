{
  description = "My system flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs =
    { self, nixpkgs }@inputs:
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
            ./configurations/nas-nixos/configuration.nix
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
