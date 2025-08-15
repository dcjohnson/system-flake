{ ... }:
{
  config = {
    disko.devices = {
      zpool = {
        zroot = {
          type = "zpool";
          mode = "raidz2";
          # Workaround: cannot import 'zroot': I/O error in disko tests
          options.cachefile = "none";

          rootFsOptions = {
            compression = "zstd";
            "com.sun:auto-snapshot" = "false";
          };
          mountpoint = "/mnt/zfs";
          #postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot@blank$' || zfs snapshot zroot@blank";

          datasets = {
            zfs_git = {
              type = "zfs_fs";
              mountpoint = "/git";
              options."com.sun:auto-snapshot" = "false";
            };
            zfs_nas = {
              type = "zfs_fs";
              mountpoint = "/nas";
              options."com.sun:auto-snapshot" = "false";
            };
          };
        };
      };

      disk = {
        zfsDisk1 = {
          type = "disk";
          device = "/dev/sda";
          content = {
            type = "gpt";
            partitions = {
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
        zfsDisk2 = {
          type = "disk";
          device = "/dev/sdb";
          content = {
            type = "gpt";
            partitions = {
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
        zfsDisk3 = {
          type = "disk";
          device = "/dev/sdc";
          content = {
            type = "gpt";
            partitions = {
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
        zfsDisk4 = {
          type = "disk";
          device = "/dev/sdd";
          content = {
            type = "gpt";
            partitions = {
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
