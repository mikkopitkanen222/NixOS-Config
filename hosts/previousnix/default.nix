# Configuration for host "previousnix".
{ lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_14;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
  };

  networking = {
    hostName = "previousnix";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  # Monitors are host specific, and are configured using Home Manager
  # (= separate for each user). Hosts don't care / know who will be using
  # the hosts, so we must configure monitors for Hyprland for all users.
  home-manager.sharedModules = [
    {
      # https://wiki.hyprland.org/Configuring/Monitors/
      wayland.windowManager.hyprland.settings.monitor = [
        # XB241H, 1920x1080@144
        # Rotated 90 degrees counter-clockwise.
        "DP-1, preferred, auto, auto, transform, 3"
        # Default placement for further monitors.
        ", preferred, auto, auto"
      ];
    }
  ];
}
