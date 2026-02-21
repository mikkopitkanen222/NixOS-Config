# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
# https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
{ lib, ... }:
{
  imports = [ ../../../desknix/users/mp/hyprland.nix ];

  home-manager.users.mp = {
    wayland.windowManager.hyprland.settings = {
      # https://wiki.hypr.land/Configuring/Monitors/
      monitorv2 = lib.mkForce [
        {
          output = "desc:AU Optronics 0x4A99";
          mode = "1920x1080@60";
          position = "0x0";
          scale = 1.0;
        }
        # Default placement for extra monitors:
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1.0;
        }
      ];

      # https://wiki.hypr.land/Configuring/Variables/#input
      input.touchpad = {
        natural_scroll = true;
        drag_lock = 1;
      };

      # https://wiki.hypr.land/Configuring/Variables/#decoration
      decoration = {
        # https://wiki.hypr.land/Configuring/Performance/#how-do-i-make-hyprland-draw-as-little-power-as-possible-on-my-laptop
        blur.enabled = lib.mkForce false;
        shadow.enabled = lib.mkForce false;
      };

      # https://wiki.hypr.land/Configuring/Workspace-Rules/
      workspace = lib.mkForce [
        "1, monitor:desc:AU Optronics 0x4A99, persistent:true"
        "10, monitor:desc:AU Optronics 0x4A99, persistent:true, layout:scrolling"
      ];
    };
  };
}
