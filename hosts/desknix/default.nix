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

  # Monitors are host specific, and are configured in Home Manager (= separate
  # for each user). Hosts don't care / know who will be using the host, so we
  # must configure monitors for Hyprland for all users.
  home-manager.sharedModules = [
    {
      wayland.windowManager.hyprland.settings.monitors = [
        # 3440x1440@180 monitor, sometimes split using PBP.
        # It prefers 60 Hz mode, so 180 Hz must be forced.
        "DP-1, highres@highrr, auto, auto"
        # DP-2 will be the right half of the monitor, if using PBP.
        "DP-2, preferred, auto, auto"
        # Second monitor on the left, rotated 90 degrees counter-clockwise.
        "HDMI-A-1, preferred, -1080x-400, auto, transform, 3"
        # Default placing for further monitors.
        ", preferred, auto, auto"
      ];
    }
  ];
}
