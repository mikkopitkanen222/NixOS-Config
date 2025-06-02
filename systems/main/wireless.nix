# Configure a wireless networking GUI.
{ pkgs, ... }:
# Can this be moved to user?
{
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Settings = {
        AutoConnect = true;
      };
    };
  };

  # Make sure iwgtk.service is enabled / starts at login.
  systemd.services.iwgtk.wantedBy = [ "graphical-session.target" ];

  # https://github.com/j-lentz/iwgtk
  environment.systemPackages = [ pkgs.iwgtk ];
}
