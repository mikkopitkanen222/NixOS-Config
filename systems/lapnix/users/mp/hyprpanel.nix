# https://github.com/Jas-SinghFSU/HyprPanel
{ lib, ... }:
{
  imports = [ ../../../desknix/users/mp/hyprpanel.nix ];

  home-manager.users.mp.programs.hyprpanel.settings = {
    bar.customModules.hypridle.pollingInterval = 5000;
    bar.layouts = {
      "*".right = lib.mkForce [
        "media"
        "network"
        "bluetooth"
        "volume"
        "microphone"
        "battery"
        "systray"
      ];
    };
    menus.power = {
      lowBatteryNotification = true;
      lowBatteryThreshold = 25;
    };
  };
}
