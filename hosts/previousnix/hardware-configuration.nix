# Configuration options dependent on hardware, file systems, etc. installed in host "previousnix".
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
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "sd_mod"
  ];
  boot.kernelModules = [
    "kvm-intel"
    "coretemp"
  ];

  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "639acf2f";
  fileSystems = {
    # nvme-Samsung_SSD_970_EVO_Plus_1TB:
    "/boot" = {
      device = "/dev/disk/by-uuid/71BB-C496";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
    "/" = {
      device = "rpool/local/root";
      fsType = "zfs";
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
    # ata-Samsung_SSD_860_EVO_1TB:
    "/mnt/ssd2" = {
      device = "/dev/disk/by-uuid/b5a5800a-8c64-4c4d-8736-b0b9cb30a5b6";
      fsType = "ext4";
    };
  };

  # Intel i7-9700K:
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Nvidia RTX 2070:
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # Fix loss of output from GPU when waking from sleep:
    open = false;
    # Fix graphics corruption when waking from sleep:
    powerManagement.enable = true;
  };
  unfree.allowedPackages = [
    "nvidia-x11"
    "nvidia-settings"
  ];
}
