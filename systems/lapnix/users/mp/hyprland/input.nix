# https://wiki.hyprland.org/Configuring/Variables/
{ ... }:
{
  imports = [ ../../../../desknix/users/mp/hyprland/input.nix ];

  home-manager.users.mp.wayland.windowManager.hyprland.settings.input.touchpad = {
    natural_scroll = "true";
    drag_lock = "true";
  };
}
