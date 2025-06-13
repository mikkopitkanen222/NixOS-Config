# Configuration options dependent on hardware, file systems, etc. installed in host "lapnix".
# Lenovo IdeaPad 1 15ALC7
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
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [
    "dm-snapshot"
    "vfat"
    "nls_cp437"
    "nls_iso8859-1"
    "usbhid"
  ];
  boot.kernelModules = [
    "kvm-amd"
    "k10temp"
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

  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "2f505119";
  fileSystems = {
    # nvme-SAMSUNG_MZAL8512HDLU-00BL2:
    "/boot" = {
      device = "/dev/disk/by-uuid/BA47-056D";
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
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/07e77238-58cc-4601-9202-681f975675ed"; }
  ];

  # AMD Ryzen 5 5500U:
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # AMD Ryzen 5 5500U iGPU:
  hardware.amdgpu = {
    # Fix archaic image resolution (640x480) during boot:
    initrd.enable = true;
    amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };

  # Fingerprint sensor:
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-elan;
    };
  };
  unfree.allowedPackages = [ (lib.getName config.services.fprintd.tod.driver) ];
}
