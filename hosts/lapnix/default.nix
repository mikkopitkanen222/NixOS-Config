# Configuration for host "lapnix".
{ lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_14;

  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      enableCryptodisk = true;
    };
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
  };

  networking = {
    hostName = "lapnix";
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
        # Basic 1920x1080@60 laptop screen.
        "eDP-1, preferred, auto, auto"
        # Default placement for external monitors.
        ", preferred, auto, auto"
      ];
    }
  ];
}
