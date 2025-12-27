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

  services.blueman.enable = true;

  networking = {
    hostName = "lapnix";
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
        powersave = true;
      };
    };
    useDHCP = lib.mkDefault true;
  };
  programs.nm-applet.enable = true;
  #environment.systemPackages = with pkgs; [ hicolor-icon-theme paper-icon-theme adwaita-icon-theme adwaita-icon-theme-legacy ];
}
