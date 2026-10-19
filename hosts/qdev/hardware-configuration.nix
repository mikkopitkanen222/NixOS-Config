{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # https://gist.github.com/CMCDragonkai/810f78ee29c8fce916d072875f7e1751
  boot.initrd.availableKernelModules = [
    "thunderbolt"
    "nvme"
    "xhci_pci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-intel" ];

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

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
