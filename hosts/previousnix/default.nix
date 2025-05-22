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

  # Monitors are host specific, and are configured in Home Manager (= separate
  # for each user). Hosts don't care / know who will be using the host, so we
  # must configure monitors for Hyprland for all users.
  home-manager.sharedModules = [
    {
      wayland.windowManager.hyprland.settings.monitors = [
        # 1920x1080@120 monitor rotated 90 degrees counter-clockwise.
        "HDMI-A-1, preferred, auto, auto, transform, 3"
        # Default placing for further monitors.
        ", preferred, auto, auto"
      ];
    }
  ];
}
