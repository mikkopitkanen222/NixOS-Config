# Desknix host configuration.
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
    hostName = "desknix";
    hostId = "639acf2f";
    useDHCP = lib.mkDefault true;
  };

  system.stateVersion = "24.11";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
