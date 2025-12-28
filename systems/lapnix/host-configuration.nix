{ pkgs, ... }:
{
  networking.hostName = "lapnix";

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

  hardware.enableRedistributableFirmware = true;
}
