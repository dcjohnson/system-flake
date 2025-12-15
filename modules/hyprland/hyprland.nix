{ config, pkgs, ... }:
{
  config = {
    services.displayManager = {
      defaultSession = "hyprland-uwsm";

      sddm = {
        theme = "${pkgs.sddm-astronaut}/share/sddm/themes/sddm-astronaut-theme";
        extraPackages = [ pkgs.sddm-astronaut ];
        enable = true;
        wayland.enable = true;
      };
    };

    programs = {
      hyprlock = {
        enable = true;
      };
      hyprland = {
        enable = true;
        withUWSM = true;
        xwayland = {
          enable = true;
        };
      };
    };

    services.blueman.enable = true;
    services.playerctld.enable = true;

    services.pulseaudio.enable = false;
    services.avahi.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Install firefox.
    programs = {
      chromium.enable = true;
    };

    environment.systemPackages = with pkgs; [
      neovim
      kitty
      home-manager
      chromium
      alsa-utils
      brightnessctl
      networkmanagerapplet
      yazi
      hypridle
      hyprlock
      hyprlauncher
      hyprland
      hyprpaper
      hyprpolkitagent
      hyprsysteminfo
      external-3rd-party-packages.rose-pine-hyprcursor
      cliphist
      font-awesome
      nautilus
      pavucontrol
      playerctl
      pasystray
      blueman
      bluez
      bluez-alsa
      bluez-tools
      bluez-headers
    ];
    fonts.packages = with pkgs; [
      font-awesome
      jetbrains-mono
    ];
  };
}
