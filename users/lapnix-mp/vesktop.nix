# nixos-config/users/lapnix-mp/vesktop.nix
# Configure Vesktop for user 'mp' on host 'lapnix'.
# https://github.com/Vencord/Vesktop
{ ... }:
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
