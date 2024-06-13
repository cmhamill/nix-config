{
  disko.devices.disk.gw = {
    type = "disk";
    device = "/dev/nvme0n1";

    content = {
      type = "gpt";

      partitions = {
        ESP = {
          type = "C12A7328-F81F-11D2-BA4B-00A0C93EC93B";
          size = "512M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "discard"
              "noatime"
              "umask=0077"
            ];
          };
        };

        root = {
          type = "CA7D7CCB-63ED-4C53-861C-1742536059CC";
          size = "100%";
          content = {
            type = "luks";
            name = "root-crypt";
            askPassword = true;
            settings = {
              allowDiscards = true;
              bypassWorkqueues = true;
            };
            content = {
              type = "btrfs";
              subvolumes = {
                "@" = {
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                    "discard=async"
                    "noatime"
                  ];
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "discard=async"
                    "noatime"
                  ];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = [
                    "compress=zstd"
                    "discard=async"
                    "noatime"
                  ];
                };
                "@swap" = {
                  mountpoint = "/swap";
                  mountOptions = [
                    "discard=async"
                    "noatime"
                  ];
                  swap.swapfile.size = "16G";
                };
              };
            };
          };
        };
      };
    };
  };
}
