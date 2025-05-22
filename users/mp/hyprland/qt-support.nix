# Configure Hyprland Qt support.
# https://wiki.hyprland.org/Hypr-Ecosystem/hyprland-qt-support/
#
# This module can be imported by user "mp" Hyprland config.
{ pkgs, ... }:
{
  home.packages = [ pkgs.hyprland-qt-support ];

  xdg.configFile."hypr/application-style.conf".text = ''
    roundness = 1
    border_width = 1
    reduce_motion = false
  '';
}
