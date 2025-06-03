# Configure clipse, a TUI clipboard manager.
# https://github.com/savedra1/clipse
#
# This module can be imported by user "mp" config.
{ pkgs, ... }:
{
  home.packages = [ pkgs.wl-clipboard ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [ "clipse -listen" ];
    bind = [ "$mainMod, V, exec, kitty --class clipse -e 'clipse'" ];
    windowrulev2 = [
      "float,class:(clipse)"
      "size 622 652,class:(clipse)"
    ];
  };

  services.clipse = {
    enable = true;
    imageDisplay.type = "kitty";
  };
}
