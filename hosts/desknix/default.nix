# Configuration for host "desknix".
{ lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxKernel.packageAliases.linux_latest;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
    keyboard.qmk.enable = true;
  };

  networking = {
    hostName = "desknix";
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
        # Primary monitor: VG34VQ3B, 3440x1440@180
        # It prefers 60 Hz mode, so 180 Hz must be forced.
        "DP-1, highres@highrr, auto, auto, bitdepth, 10, cm, auto, vrr, 1"
        # Secondary monitor: XB241H, 1920x1080@144
        # Runs at only 60 Hz when connected using HDMI.
        # Position on the left, rotated 90 degrees counter-clockwise.
        "HDMI-A-1, preferred, -1080x-400, auto, transform, 3"
        # Default placement for further monitors.
        ", preferred, auto, auto"
      ];
    }
  ];
}
