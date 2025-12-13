{ pkgs, ... }:
{
  home.username = "dcj";
  home.homeDirectory = "/home/dcj";
  home.stateVersion = "24.11"; # Comment out for error with "latest" version
  programs = {
    home-manager = {
      enable = true;
    };
    ashell = import ./configs/ashell.nix;
  };
  wayland.windowManager.hyprland = {
    systemd.enable = false;
    enable = true;
    settings = import ./configs/hyprland.nix;
  };
  services = {
    network-manager-applet = {
      enable = true;
    };
    pasystray = {
      enable = true;
    };
    hyprpaper = {
      enable = true;
      settings = import ./configs/hyprpaper.nix;
    };
  };
}
