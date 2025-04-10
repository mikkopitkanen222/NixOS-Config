# Configuration for host "desknix".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Build this host by setting the attribute "system.hostName" in flake.nix.
  hostName = "desknix";

  # Configure hardware, filesystems, and other device specific options:
  hostConfig = lib.mkMerge [
    # Versions
    {
      system.stateVersion = "25.05";
      boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_14;
    }
    # Boot
    {
      # https://gist.github.com/CMCDragonkai/810f78ee29c8fce916d072875f7e1751
      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "usbhid"
      ];
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    }
    # Networking
    {
      networking = {
        inherit hostName;
        hostId = "e375a759";
        networkmanager.enable = true;
        useDHCP = lib.mkDefault true;
      };
      hardware.bluetooth.enable = true;
    }
    # CPU
    {
      boot.kernelModules = [
        "kvm-amd"
        "k10temp"
      ];
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    }
    # GPU
    {
      hardware.graphics.enable = true;
      services.xserver.videoDrivers = [
        "amdvlk"
        "radv"
        "amdgpu"
      ];
    }
    # Disks
    {
      boot.initrd.availableKernelModules = [
        "ahci"
        "nvme"
      ];

      services.btrfs.autoScrub = {
        enable = true;
        interval = "weekly";
        fileSystems = [ "/" ];
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

      swapDevices = [ ];
    }
  ];
in
{
  config = lib.mkMerge [
    # Merge this host's hostName to the list of all hostNames.
    ({ system.allHostNames = [ hostName ]; })
    # Build this host's configuration if its hostName is set in flake.nix.
    (lib.mkIf (config.system.hostName == hostName) hostConfig)
  ];
}
