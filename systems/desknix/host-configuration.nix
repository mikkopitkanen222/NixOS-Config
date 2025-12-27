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
    bluetooth.enable = true;
    keyboard.qmk.enable = true;
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  services.blueman.enable = true;

  networking = {
    hostName = "desknix";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    useDHCP = lib.mkDefault true;
  };
  programs.nm-applet.enable = true;
}
