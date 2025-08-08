{
  config,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    ./default.nix
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  config = {
    environment.systemPackages = [
      pkgs.djohnson-packages.odroid-h4-plus-nas-installer
    ];
  };
}
