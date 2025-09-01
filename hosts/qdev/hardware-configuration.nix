# nixos-config/hosts/qdev/hardware-configuration.nix
# Configure hardware, file systems, etc. dependent options on host 'qdev'.
# Lenovo ThinkPad T16 Gen 2
{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # https://gist.github.com/CMCDragonkai/810f78ee29c8fce916d072875f7e1751
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [
    "kvm-intel"
    "coretemp"
  ];

  fileSystems = {
    # WD PC SN740 SDDQNQD-512G-1201:
    # 150 GiB partition for NixOS:
    "/" = {
      device = "/dev/disk/by-uuid/efaac589-29da-4738-93aa-8492bd99fe7a";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "subvol=root"
      ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/efaac589-29da-4738-93aa-8492bd99fe7a";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "noatime"
        "subvol=nix"
      ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/efaac589-29da-4738-93aa-8492bd99fe7a";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "subvol=home"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/F025-F9E8";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
  services.snapper = {
    snapshotInterval = "hourly";
    cleanupInterval = "1h";
    configs = {
      "root" = {
        SUBVOLUME = "/";
        ALLOW_USERS = [ "mp" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = 0;
        TIMELINE_LIMIT_DAILY = 7;
        TIMELINE_LIMIT_WEEKLY = 6;
        TIMELINE_LIMIT_MONTHLY = 0;
        TIMELINE_LIMIT_YEARLY = 0;
      };
      "nix" = {
        SUBVOLUME = "/nix";
        ALLOW_USERS = [ "mp" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = 0;
        TIMELINE_LIMIT_DAILY = 7;
        TIMELINE_LIMIT_MONTHLY = 0;
        TIMELINE_LIMIT_YEARLY = 0;
      };
      "home" = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "mp" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = 8;
        TIMELINE_LIMIT_DAILY = 5;
        TIMELINE_LIMIT_MONTHLY = 0;
        TIMELINE_LIMIT_YEARLY = 0;
      };
    };
  };

  # Intel Core i7-1355U:
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Fingerprint sensor:
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-elan; # TODO: Check if this is correct for thinkpad
    };
  };
}
