# nixos-config/users/qdev-mp/hyprland/input.nix
# Configure Hyprland input methods for user 'mp' on host 'qdev'.
# https://wiki.hyprland.org/Configuring/Variables/
{ ... }:
{
  home-manager.users.mp = {
    wayland.windowManager.hyprland.settings = {
      input = {
        kb_model = "pc105";
        kb_layout = "fi";
        kb_variant = "winkeys";
        numlock_by_default = "true";
        scroll_method = "on_button_down";
        scroll_button = "274";
        scroll_factor = "0.59";

        touchpad = {
          natural_scroll = "true";
          drag_lock = "true";
        };
      };
    };
  };
}
