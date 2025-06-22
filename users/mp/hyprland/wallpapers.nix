# Configure hyprpaper.
# https://github.com/hyprwm/hyprpaper
#
# This module can be imported by user "mp" Hyprland config.
{ pkgs, ... }:
{
  systemd.user.services.hyprpaper.Install.WantedBy = [ "default.target" ];

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      reload =
        let
          space-png = pkgs.fetchurl {
            # The requested URL returns error 403 when no user agent is set:
            curlOpts = "--user-agent 'Chrome/137.0.0.0'";
            url = "https://wallpapercave.com/download/3440x1440-space-wallpapers-wp11599666";
            hash = "sha256-j/y5Dfghb8iC+d0KjH+hYGlfiM6foxo3Xmt3KlkJkbU=";
          };
        in
        [ ",${space-png}" ];
    };
  };
}
