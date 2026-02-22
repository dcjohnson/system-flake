{ config, pkgs, ... }:

{
  imports = [
    ../hyprland/hyprland.nix
    ./hardware-configuration.nix
  ];

  config = {
    # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    # Set your time zone.
    time.timeZone = "America/Los_Angeles";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };
    services.rpcbind.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.dcj = {
      isNormalUser = true;
      description = "Dylan Conrad Johnson";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [ ];
    };

    # Install firefox.
    programs = {
      chromium.enable = true;
      firefox.enable = false;
      tmux.enable = true;
      _1password.enable = true;
      _1password-gui.enable = true;
    };

    environment.systemPackages = with pkgs; [
      neovim
      gparted
      minicom
      xnconvert
      kitty
      gimp2-with-plugins
      git
      chromium
      openssl
      ntfs3g
      bftpd
      parted
      file
      wget
      curl
      jetbrains-mono
      nfs-utils
      sl
      texliveFull
      gnumake
      wireguard-tools
    ];

    security = {
      wrappers = {
        "mount.nfs" = {
          setuid = true;
          owner = "root";
          group = "root";
          source = "${pkgs.nfs-utils}/bin/mount.nfs";
        };
      };
      rtkit = {
        enable = true;
      };
    };

    system.stateVersion = "24.11"; # Do not change.
  };
}
