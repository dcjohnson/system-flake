{ pkgs, ... }:
{
  home = {
    username = "dcj";
    homeDirectory = "/home/dcj";
    stateVersion = "24.11"; # Comment out for error with "latest" version
    file = {
      "wallpapers" = {
        enable = true;
        target = "./.config/wallpapers";
        source = ./wallpapers;
        recursive = true;
      };
    };
  };
  programs = {
    home-manager = {
      enable = true;
    };

  ashell = { enable = true;
  systemd = {
    enable = true;
  };
settings = import ./configs/ashell.nix;
};
  };
  wayland.windowManager.hyprland = {
    systemd.enable = false;
    enable = true;
    settings = import ./configs/hyprland.nix;
  };
  services = {
    cliphist = {
      enable = true;
      allowImages = true;
    };
    hyprpolkitagent = {
      enable = true;
    };
    network-manager-applet = {
      enable = false;
    };
    pasystray = {
      enable = false;
    };
    hypridle = {
      enable = true;
      settings = import ./configs/hypridle.nix;
    };
    hyprpaper = {
      enable = true;
      settings = import ./configs/hyprpaper.nix;
    };
  };
}
