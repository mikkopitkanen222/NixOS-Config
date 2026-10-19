# https://github.com/Vencord/Vesktop
{ config, lib, ... }:
let
  cfg = config.mp222.vesktop;
in
{
  options.mp222.vesktop = {
    enable = lib.mkEnableOption "Vesktop";
  };

  config = lib.mkIf cfg.enable {
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
