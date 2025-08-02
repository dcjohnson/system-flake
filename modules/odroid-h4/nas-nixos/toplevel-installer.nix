{ config, pkgs, ... }:
{
  imports = [
    ./toplevel.nix
    (modulesPath + "/installer/cd-dvd/instalation-cd-minimal.nix")
  ];

  config = { 
    environment.systemPackages = [
      pkgs.djohnson-packages.odroid-h4-plus-nas-installer
    ];
  };
}
