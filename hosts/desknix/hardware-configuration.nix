# Configuration options dependent on hardware, file systems, etc. installed in host "desknix".
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
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
  ];
  boot.kernelModules = [
    "kvm-amd"
    "zenpower"
  ];

  fileSystems = {
    # nvme-Samsung_SSD_9100_PRO_2TB:
    # (minus 500GiB partition for Windows (yuck!))
    "/" = {
      device = "/dev/disk/by-uuid/20fc2412-5fd5-4a3b-a86d-2c9d8fcd32d3";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "subvol=root"
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
    "/boot" = {
      device = "/dev/disk/by-uuid/6308-5111";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
    # nvme-Samsung_SSD_990_PRO_2TB:
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

  # AMD Ryzen 9 9950X3D:
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # AMD Radeon RX 9070 XT:
  hardware.amdgpu = {
    # Fix archaic image resolution (640x480) during boot:
    initrd.enable = true;
    opencl.enable = true;
    amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };
}
