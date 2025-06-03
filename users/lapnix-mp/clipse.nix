# nixos-config/users/lapnix-mp/clipse.nix
# Configure Clipse for user 'mp' on host 'lapnix'.
# https://github.com/savedra1/clipse
{ pkgs, ... }:
{
  home-manager.users.mp = {
    home.packages = [ pkgs.wl-clipboard ];

    wayland.windowManager.hyprland.settings = {
      exec-once = [ "clipse -listen" ];
      windowrulev2 = [
        "float,class:(clipse)"
        "size 622 652,class:(clipse)"
      ];
    };

    services.clipse = {
      enable = true;
      imageDisplay.type = "kitty";
    };
  };
}
