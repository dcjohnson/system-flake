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

  boot.supportedFilesystems = [ ];

  fileSystems."/mnt/nas" = {
    device = "nas.homenet:/mnt/nas";
    fsType = "nfs";
  };

  # Enable networking
  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    hostId = "1ca2fdc2";
    hostName = "schwab1"; # Define your hostname.
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
  };
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
