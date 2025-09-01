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
          output = "desc:Lenovo Group Limited D27-40 URHMMCKN";
          mode = "1920x1080@60";
          position = "0x0";
          scale = 1.0;
        }
        {
          output = "desc:Lenovo Group Limited LEN T27h-20 VNA5XD80";
          mode = "2560x1440@60";
          # Position on the left, rotated 90 degrees counter-clockwise:
          position = "-1440x-1000";
          transform = 3;
          scale = 1.0;
        }
        {
          output = "desc:Chimei Innolux Corporation 0x1614";
          mode = "1920x1200@60";
          # Position on the right:
          position = "1920x350";
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
        "1, monitor:desc:Lenovo Group Limited D27-40 URHMMCKN, persistent:true, default:true"
        "2, monitor:desc:Lenovo Group Limited LEN T27h-20 VNA5XD80, persistent:true, default:true"
        "3, monitor:desc:Chimei Innolux Corporation 0x1614, persistent:true, default:true"
        "10, monitor:desc:Lenovo Group Limited D27-40 URHMMCKN, persistent:true, layout:scrolling"
      ];
    };
  };
}
