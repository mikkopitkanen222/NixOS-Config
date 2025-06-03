# Configure clipse.
# https://github.com/savedra1/clipse
#
# This module can be imported by user "mp" Hyprland config.
{ pkgs, ... }:
{
  home.packages = [ pkgs.wl-clipboard ];

  wayland.windowManager.hyprland.settings.exec-once = [ "clipse -listen" ];

  services.clipse = {
    enable = true;
    imageDisplay.type = "kitty";
  };
}
