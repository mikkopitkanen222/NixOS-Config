# https://github.com/Vencord/Vesktop
{ config, lib, ... }:
let
  cfg = config.mp222.clipse;
in
{
  home-manager.users.mp = {
    programs.vesktop = {
      enable = true;
      settings = {
        discordBranch = "stable";
        tray = true;
        minimizeToTray = true;
        hardwareAcceleration = true;
        hardwareVideoAcceleration = true;
        arRPC = true;
        appBadge = true;
        clickTrayToShowHide = true;
      };
      vencord = {
        settings = {
          autoUpdate = true;
          autoUpdateNotification = false;
          useQuickCss = true;
        };
        # Without this Vesktop fails to launch ("eglCreateImage failed"):
        useSystem = true;
      };
    };
  };
}
