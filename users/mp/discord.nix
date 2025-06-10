# Configure vesktop, a Discord client with Wayland support.
# https://github.com/Vencord/Vesktop
#
# This module can be imported by user "mp" config.
{ ... }:
{
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
}
