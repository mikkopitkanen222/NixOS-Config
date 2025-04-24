# Configuration for host "previousnix".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  hostName = "previousnix";

  hostConfig = {
    # https://gist.github.com/CMCDragonkai/810f78ee29c8fce916d072875f7e1751
    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "ahci"
      "nvme"
      "sd_mod"
    ];

    system.stateVersion = "24.11";
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_13;

    networking = {
      inherit hostName;
      hostId = "639acf2f";
      networkmanager.enable = true;
      useDHCP = lib.mkDefault true;
    };
    hardware.bluetooth.enable = true;

    build.host.cpu.intel = true;
    build.host.gpu.nvidia = true;

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    boot.supportedFilesystems = [ "zfs" ];

    fileSystems = {
      "/" = {
        device = "rpool/local/root";
        fsType = "zfs";
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/71BB-C496";
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
      "/mnt/ssd2" = {
        device = "/dev/disk/by-uuid/b5a5800a-8c64-4c4d-8736-b0b9cb30a5b6";
        fsType = "ext4";
      };
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
