{
  disko,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
  ];

  config = {
    # Bootloader.
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
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

    services.nfs = {
      server = {
        enable = true;
      };
    };

    services.samba = {
      enable = true;
      settings = {
        global = {
          "usershare path" = "/var/lib/samba/usershares";
          "usershare max shares" = "100";
          "usershare allow guests" = "yes";
          "usershare owner only" = "no";
          "security" = "user";
          "read only" = "no";
          "guest account" = "nasguest";
        };
      };
      openFirewall = true;
    };

    services.zfs = {
      autoScrub.enable = true;
      autoSnapshot.enable = true;
    };

    # Enable the X11 windowing system.
    services.xserver.enable = false;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = false;
    services.xserver.desktopManager.gnome.enable = false;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users = {
      groups = {
        nas = {
          gid = 1000;
        };
      };
      users = {
        admin = {
          isNormalUser = true;
          description = "administrator";
          extraGroups = [
            "networkmanager"
            "wheel"
            "nas"
          ];
          packages = with pkgs; [ ];
        };

        nasguest = {
          isSystemUser = true;
          description = "nas guest";
          group = "nas";
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
          uid = 70;
          packages = with pkgs; [ ];
        };
      };
    };

    # Install firefox.
    programs.firefox.enable = false;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      neovim
      wget
      curl
      zfs
      dhcpcd
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?
  };
}
