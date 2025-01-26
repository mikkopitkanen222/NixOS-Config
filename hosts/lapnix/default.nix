# Lapnix host configuration.
{
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disks.nix
    ./hardware.nix
  ];

  networking = {
    hostName = "lapnix";
    hostId = "2f505119";
    useDHCP = lib.mkDefault true;
  };

  system.stateVersion = "24.11";

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
