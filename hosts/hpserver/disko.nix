{
  disko.devices = {
    disk = {
      boot = {
        type = "disk";
        device = "/dev/sdg";
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
            swap = {
              size = "16G";
              type = "8200";
              content = {
                type = "swap";
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
        device = "/dev/sda";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data2 = {
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data3 = {
        type = "disk";
        device = "/dev/sdc";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data4 = {
        type = "disk";
        device = "/dev/sdd";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data5 = {
        type = "disk";
        device = "/dev/sde";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data6 = {
        type = "disk";
        device = "/dev/sdf";
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
