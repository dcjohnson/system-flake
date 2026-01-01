{
  inputs,
  config,
  pkgs,
  ...
}:
{
  config = {
    services.displayManager = {
      defaultSession = "hyprland-uwsm";

      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
        theme = "${pkgs.flake-packages.custom-sddm-astro-mountain_night_sky}/share/sddm/themes/sddm-astronaut-theme";
        extraPackages = [ pkgs.flake-packages.custom-sddm-astro-mountain_night_sky ];
        #theme = "${pkgs.flake-packages.custom-sddm-astro-mountains}/share/sddm/themes/sddm-astronaut-theme";
        #extraPackages = [ pkgs.flake-packages.custom-sddm-astro-mountains ];
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
      waybar
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
      kdePackages.qtsvg
      hypridle
      hyprlock
      hyprlauncher
      hyprland
      hyprpaper
      hyprpolkitagent
      hyprsysteminfo
      external-packages.rose-pine-hyprcursor
      cliphist
      font-awesome
      nautilus
      pavucontrol
      playerctl
      pasystray
      pipewire
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
