{ lib, pkgs, ... }:
{
  system.stateVersion = "25.11";
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
    bluetooth.enable = true;
  };

  networking = {
    hostName = "lapnix";
    useDHCP = lib.mkDefault true;
  };
}
