{
  disko.devices = {
    disk = {
      boot = {
        type = "disk";
        device = "/dev/sda";
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
      nix = {
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "gpt";
          partitions = {
            swap = {
              size = "16G";
              content = {
                type = "swap";
                randomencryption = true;
              };
            };
            nix = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
              };
            };
          };
        };
      };
      data1 = {
        type = "disk";
        device = "/dev/sdc";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data2 = {
        type = "disk";
        device = "/dev/sdd";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data3 = {
        type = "disk";
        device = "/dev/sde";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data4 = {
        type = "disk";
        device = "/dev/sdf";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data5 = {
        type = "disk";
        device = "/dev/sdg";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
      data6 = {
        type = "disk";
        device = "/dev/sdh";
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
