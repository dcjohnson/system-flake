{ ... }:
{
  config = {
    disko.devices = {
      disk = {
        nvme0n1 = {
          device = "/dev/nvme0n1";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              nvme0n1p1 = {
                type = "EF00";
                name = "ESP";
                start = "1MiB";
                end = "500MiB";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [
                    "umask=0077"
                  ];
                };
              };
              nvme0n1p2 = {
                name = "root";
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "btrfs";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}
