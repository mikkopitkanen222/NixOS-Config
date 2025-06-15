# Configure Hyprland outputs.
# https://wiki.hypr.land/Configuring/Monitors/
#
# This module can be imported by user "mp" Hyprland config.
{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor =
      {
        desknix = [
          # Primary monitor: VG34VQ3B, 3440x1440@180
          # Prefers 60 Hz mode, so 180 Hz must be forced.
          "DP-1, highres@highrr, auto, auto, bitdepth, 10, cm, auto, vrr, 2"
          # Secondary monitor: KG241 P, 1920x1080@144
          # Prefers 60 Hz mode, so 144 Hz must be forced.
          # Position on the left, rotated 90 degrees counter-clockwise.
          "HDMI-A-1, highres@highrr, -1080x-400, auto, transform, 3"
        ];
        lapnix = [
          # Basic 1920x1080@60 laptop screen.
          "eDP-1, preferred, auto, auto"
        ];
        previousnix = [
          # KG241 P, 1920x1080@144
          # Rotated 90 degrees counter-clockwise.
          "HDMI-A-1, highres@highrr, auto, auto, transform, 3"
        ];
      }
      .${config.networking.hostName}
      ++ [
        # Default placement for extra monitors.
        ", preferred, auto, auto"
      ];
  };
}
