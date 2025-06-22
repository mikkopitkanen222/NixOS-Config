# nixos-config/users/desknix-mp/hyprland/hyprpaper.nix
# Configure Hyprpaper for user 'mp' on host 'desknix'.
# https://github.com/hyprwm/hyprpaper
{ pkgs, ... }:
{
  home-manager.users.mp = {
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
  };
}
