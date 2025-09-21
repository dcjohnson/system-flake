{ ... }:
{
  config = {
    disko.devices = {
      disk = {
        nvme0n1 = {
          type = "disk";
          device = "/dev/nvme0n1";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "64M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              zfs = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "zroot";
                };
              };
            };
          };
        };
      };
      zpool = {
        zroot = {
          type = "zpool";
          mode = "";
          # Workaround: cannot import 'zroot': I/O error in disko tests
          options.cachefile = "none";
          rootFsOptions = {
            compression = "zstd";
            "com.sun:auto-snapshot" = "true";
            canmount = "on";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
