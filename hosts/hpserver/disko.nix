{
  disko.devices = {
    disk = {
      boot = {
        type = "disk";
        label = "boot";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02";
            };
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
            swap = {
              size = "16G";
              content = {
                type = "swap";
                randomEncryption = true;
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      data1 = {
        type = "disk";
        label = "data1";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data2 = {
        type = "disk";
        label = "data2";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data3 = {
        type = "disk";
        label = "data3";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data4 = {
        type = "disk";
        label = "data4";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data5 = {
        type = "disk";
        label = "data5";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data6 = {
        type = "disk";
        label = "data6";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
    };
    zpool = {
      data = {
        type = "zpool";
        mode = "raidz1";
        options.cachefile = "none";
        rootFsOptions = {
          compression = "zstd";
        };
        datasets = {
          data = {
            type = "zfs_fs";
            mountpoint = "/data";
          };
          media = {
            type = "zfs_fs";
            mountpoint = "/media";
          };
        };
      };
    };

  };
}
