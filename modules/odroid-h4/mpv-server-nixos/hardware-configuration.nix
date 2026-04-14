{
  config,
  lib,
  pkgs,
  modulesPath,
  disko,
  ...
}:

{
  imports = [
    disko.nixosModules.disko
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "sdhci_pci"
      ];
      kernelModules = [ ];
    };
    supportedFilesystems = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };
  # Enable networking
  networking = {
    interfaces = {
      enp1s0 = {
        useDHCP = lib.mkDefault true;
      };
      enp2s0 = {
        useDHCP = lib.mkDefault false;
      };
    };

    firewall = {
      allowedTCPPorts = [
        443
        22
      ];

      allowedUDPPorts = [
        53
      ];
    };

    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    hostId = "1ca2fdc4";
    hostName = "mpv-server"; # Define your hostname.
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
  };
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
