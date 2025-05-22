# nixos-config/users/desknix-mp/hyprland/monitors.nix
# Configure Hyprland outputs for user 'mp' on host 'desknix'.
# https://wiki.hypr.land/Configuring/Monitors/
{ ... }:
{
  home-manager.users.mp = {
    wayland.windowManager.hyprland.settings = {
      monitorv2 = [
        # Primary monitor (VG34VQ3B, 3440x1440@180):
        {
          output = "DP-1";
          # Prefers 60 Hz mode, so 180 Hz must be forced.
          mode = "highres@highrr";
          position = "auto";
          scale = "auto";
          bitdepth = "10";
          cm = "auto";
          vrr = "2";
        }
        # Secondary monitor (KG241 P, 1920x1080@144):
        {
          output = "HDMI-A-1";
          # Prefers 60 Hz mode, so 144 Hz must be forced.
          mode = "highres@highrr";
          # Position on the left, rotated 90 degrees counter-clockwise.
          position = "-1080x-400";
          scale = "auto";
          transform = "3";
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
