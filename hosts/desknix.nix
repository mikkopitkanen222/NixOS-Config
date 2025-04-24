# Configuration for host "desknix".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  hostName = "desknix";

  hostConfig = {
    # https://gist.github.com/CMCDragonkai/810f78ee29c8fce916d072875f7e1751
    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "ahci"
      "nvme"
      "sd_mod"
    ];

    system.stateVersion = "25.05";
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_14;

    networking = {
      inherit hostName;
      hostId = "e375a759";
      networkmanager.enable = true;
      useDHCP = lib.mkDefault true;
    };
    hardware.bluetooth.enable = true;

    hardware.keyboard.qmk.enable = true;

    build.host = {
      cpu = {
        maker = "amd";
        updateMicrocode = true;
      };
      gpu = {
        maker = "amd";
        opencl.enable = true;
        initrd.enable = true;
      };
    };

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/20fc2412-5fd5-4a3b-a86d-2c9d8fcd32d3";
        fsType = "btrfs";
        options = [
          "compress=zstd"
          "subvol=root"
        ];
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/6308-5111";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };
      "/nix" = {
        device = "/dev/disk/by-uuid/20fc2412-5fd5-4a3b-a86d-2c9d8fcd32d3";
        fsType = "btrfs";
        options = [
          "compress=zstd"
          "noatime"
          "subvol=nix"
        ];
      };
      "/home" = {
        device = "/dev/disk/by-uuid/20fc2412-5fd5-4a3b-a86d-2c9d8fcd32d3";
        fsType = "btrfs";
        options = [
          "compress=zstd"
          "subvol=home"
        ];
      };
      "/persist" = {
        device = "/dev/disk/by-uuid/4f3c5398-23bd-431b-89ae-d270ed393630";
        fsType = "btrfs";
        options = [
          "compress=zstd"
          "subvol=persist"
        ];
      };
    };

    services.btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [ "/" ];
    };

    swapDevices = [ ];
  };
in
{
  options = {
    build.hostName = lib.mkOption { type = lib.types.enum [ hostName ]; };
  };

  config = lib.mkIf (config.build.hostName == hostName) hostConfig;
}
