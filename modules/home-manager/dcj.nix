{ pkgs, ... }:
{

  home.username = "dcj";
  home.homeDirectory = "/home/dcj";
  home.stateVersion = "24.11"; # Comment out for error with "latest" version
  programs.home-manager.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = import ./hyprland-configs/config.nix;
  };
}
