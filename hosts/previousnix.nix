# Configuration for host "previousnix".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Build this host by setting the attribute "system.hostName" in flake.nix.
  hostName = "previousnix";

  # Configure hardware, disks, and other device specific options:
  hostConfig = lib.mkMerge [
    # Versions
    {
      system.stateVersion = "24.11";
      boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_13;
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
        hostId = "639acf2f";
        networkmanager.enable = true;
        useDHCP = lib.mkDefault true;
      };
      hardware.bluetooth.enable = true;
    }
    # CPU
    {
      boot.kernelModules = [
        "kvm-intel"
        "coretemp"
      ];
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    }
    # GPU
    {
      # https://wiki.nixos.org/wiki/Graphics
      # https://wiki.nixos.org/wiki/NVIDIA

      hardware.graphics.enable = true;
      unfree.allowedPackages = [
        "nvidia-x11"
        "nvidia-settings"
      ];
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        gsp.enable = true;
        # RTX 2070 supports open source kernel modules,
        # but there's no output from GPU when waking from sleep.
        open = false;
        # Fix graphics corruption when waking from sleep.
        powerManagement.enable = true;
      };
    }
    # Disks
    {
      boot.initrd.availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
      ];

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
    }
  ];
in
{
  imports = [ ../modules/unfree.nix ];

  config = lib.mkMerge [
    # Merge this host's hostName to the list of all hostNames.
    ({ system.allHostNames = [ hostName ]; })
    # Build this host's configuration if its hostName is set in flake.nix.
    (lib.mkIf (config.system.hostName == hostName) hostConfig)
  ];
}
