{ lib, pkgs, ... }:
{
  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader = {
    timeout = 0;
    systemd-boot = {
      enable = true;
      consoleMode = "max";
    };
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  networking = {
    hostName = "desknix";
    useDHCP = lib.mkDefault true;
  };
}
