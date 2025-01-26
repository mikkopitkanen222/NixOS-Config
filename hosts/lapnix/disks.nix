# Lapnix disk configuration.
{ ... }:
{
  # https://gist.github.com/CMCDragonkai/810f78ee29c8fce916d072875f7e1751
  boot.initrd = {
    availableKernelModules = [
      "ahci"
      "nvme"
      "sdhci_pci"
    ];
    kernelModules = [
      "dm-snapshot"
      "vfat"
      "nls_cp437"
      "nls_iso8859-1"
      "usbhid"
    ];
    luks = {
      yubikeySupport = true;
      devices = {
        crypted-nixos = {
          device = "/dev/disk/by-uuid/b0eb28f6-6f1b-4435-a9d2-358add796510";
          preLVM = true;
          yubikey = {
            slot = 2;
            twoFactor = true;
            storage = {
              device = "/dev/disk/by-uuid/BA47-056D";
            };
          };
        };
      };
    };
  };

  boot.supportedFilesystems = [ "zfs" ];

  fileSystems = {
    "/" = {
      device = "rpool/local/root";
      fsType = "zfs";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/BA47-056D";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
    "/nix" = {
      device = "rpool/local/nix";
      fsType = "zfs";
    };
    "/home" = {
      device = "rpool/safe/home";
      fsType = "zfs";
    };
    "/persist" = {
      device = "rpool/safe/persist";
      fsType = "zfs";
    };
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/07e77238-58cc-4601-9202-681f975675ed"; } ];
}
