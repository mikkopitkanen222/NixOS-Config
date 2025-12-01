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
  boot.kernelModules = [
    "kvm-amd"
    "k10temp"
  ];

  boot.initrd = {
    systemd.enable = true;
    luks.devices."crypted".device = "/dev/disk/by-partlabel/luks";
  };

  # AMD Ryzen 5 5500U:
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # AMD Ryzen 5 5500U iGPU:
  hardware.amdgpu = {
    # Fix archaic image resolution (640x480) during boot:
    initrd.enable = true;
  };

  # Fingerprint sensor:
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-elan;
    };
  };
}
