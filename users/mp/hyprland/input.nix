# Configure Hyprland input methods.
# https://wiki.hyprland.org/Configuring/Variables/
#
# This module can be imported by user "mp" Hyprland config.
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_model = "pc104";
      kb_layout = "fi";
      kb_variant = "winkeys";
      kb_options = "terminate:ctrl_alt_bksp";
      numlock_by_default = "true";
      scroll_factor = "0.75";

      touchpad = {
        natural_scroll = "true";
        drag_lock = "true";
      };
    };
  };
}
