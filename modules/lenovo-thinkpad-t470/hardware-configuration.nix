{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "nfs" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c66249d6-fab4-4e8d-93fb-071eb1abc210";
    fsType = "ext4";
  };

  fileSystems."/mnt/nas" = {
    device = "nas.homenet:/mnt/nas";
    fsType = "nfs";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/f43c2ce7-d139-42f9-94da-f0fcbe231239"; }
  ];

  networking = {
    hostName = "nixos"; # Define your hostname.

    networkmanager = {
      enable = true;
    };

    useDHCP = lib.mkDefault true;

    wg-quick.interfaces = {
      wg0 = {
        address = [
          "192.168.100.2/32"
        ];
	dns = [ "192.168.88.1" ];
        privateKeyFile = "/root/wireguard-keys/privatekey";
        peers = [
          {
            publicKey = "9vutSlRX+xoepVItaB7FcQXXx8XYYqMTBovuqusO/UM=";
            allowedIPs = [
              "0.0.0.0/0"
            ];
            endpoint = "104.9.83.162:13231";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };
}
