# Configure Hyprland windows and workspaces.
# https://wiki.hyprland.org/Configuring/Window-Rules/
# https://wiki.hyprland.org/Configuring/Workspace-Rules/
#
# This module can be imported by user "mp" Hyprland config.
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Ignore maximize requests from apps.
      "suppressevent maximize, class:.*"
      # Fix some dragging issues with XWayland.
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
  };
}
