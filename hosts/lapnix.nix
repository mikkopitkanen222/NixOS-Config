# Configuration for host "lapnix".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Build this host by setting the attribute "system.hostName" in flake.nix.
  hostName = "lapnix";

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

      boot.initrd.kernelModules = [
        "dm-snapshot"
        "vfat"
        "nls_cp437"
        "nls_iso8859-1"
        "usbhid"
      ];
      boot.initrd.luks = {
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

      boot.loader = {
        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          enableCryptodisk = true;
        };
        efi.canTouchEfiVariables = true;
      };
    }
    # Networking
    {
      networking = {
        inherit hostName;
        hostId = "2f505119";
        networkmanager.enable = true;
        useDHCP = lib.mkDefault true;
      };
      hardware.bluetooth.enable = true;
    }
    # Fingerprint
    {
      unfree.allowedPackages = [ "libfprint-2-tod1-elan" ];
      services.fprintd = {
        enable = true;
        tod = {
          enable = true;
          driver = pkgs.libfprint-2-tod1-elan;
        };
      };
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
    # Disks
    {
      boot.initrd.availableKernelModules = [
        "ahci"
        "nvme"
        "sdhci_pci"
      ];

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
  ];
in
{
  imports = [
    ../modules/unfree.nix
  ];

  config = lib.mkMerge [
    # Merge this host's hostName to the list of all hostNames.
    ({ system.allHostNames = [ hostName ]; })
    # Build this host's configuration if its hostName is set in flake.nix.
    (lib.mkIf (config.system.hostName == hostName) hostConfig)
  ];
}
