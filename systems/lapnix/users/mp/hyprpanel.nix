# https://github.com/Jas-SinghFSU/HyprPanel
{ ... }:
{
  imports = [ ../../../desknix/users/mp/hyprpanel.nix ];

  home-manager.users.mp.programs.hyprpanel.settings = {
    bar.customModules = {
      netstat.pollingInterval = 5000;
      hypridle.pollingInterval = 5000;
    };
    menus.power = {
      lowBatteryNotification = true;
      lowBatteryThreshold = 25;
    };
  };
}
