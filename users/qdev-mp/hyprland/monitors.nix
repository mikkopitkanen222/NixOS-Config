# nixos-config/users/qdev-mp/hyprland/monitors.nix
# Configure Hyprland outputs for user 'mp' on host 'qdev'.
# https://wiki.hypr.land/Configuring/Monitors/
{ ... }:
{
  home-manager.users.mp = {
    wayland.windowManager.hyprland.settings = {
      monitorv2 = [
        # Primary monitor (D27-40, 1920x1080@60):
        {
          output = "DP-6";
          mode = "preferred";
          position = "0x0";
          scale = "auto";
        }
        # Secondary monitor (LEN T27h-20, 2560x1440@60):
        {
          output = "HDMI-A-1";
          mode = "preferred";
          # Position on the left, rotated 90 degrees counter-clockwise.
          position = "-1440x-950";
          scale = "auto";
          transform = "3";
        }
        # Basic laptop screen (1920x1200@60):
        {
          output = "eDP-1";
          mode = "preferred";
          position = "1920x600";
          scale = "auto";
        }
        # Default placement for extra monitors:
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = "auto";
        }
      ];
    };
  };
}
