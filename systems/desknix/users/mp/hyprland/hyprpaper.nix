# https://github.com/hyprwm/hyprpaper
{ pkgs, ... }:
{
  home-manager.users.mp = {
    services.hyprpaper = {
      enable = true;
      package = pkgs.unstable.hyprpaper;
      settings = {
        splash = false;
        wallpaper = [
          {
            monitor = "";
            path = "${pkgs.fetchurl {
              # The requested URL returns error 403 when no user agent is set:
              curlOpts = "--user-agent 'Chrome/137.0.0.0'";
              url = "https://wallpapercave.com/download/3440x1440-space-wallpapers-wp11599666";
              hash = "sha256-j/y5Dfghb8iC+d0KjH+hYGlfiM6foxo3Xmt3KlkJkbU=";
            }}";
          }
        ];
      };
    };
  };
}
