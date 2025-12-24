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
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.supportedFilesystems = [ "zfs" ];

  boot.zfs = {
    forceImportRoot = true;
    forceImportAll = true;
    devNodes = "/dev/disk/by-id";
    extraPools = [ "zroot" ];
  };
  # Enable networking
  networking = {
    interfaces.enp1s0.useDHCP = lib.mkDefault true;
    interfaces.enp2s0 = {
      useDHCP = lib.mkDefault false;
      ipv4 = {
        addresses = [
          {
            address = "192.168.200.2";
            prefixLength = 24;
          }
        ];
      };
    };

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    firewall.allowedTCPPorts = [ 2049 ];
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    hostId = "1ca2fdc1";
    hostName = "nas1"; # Define your hostname.
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
  };
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
