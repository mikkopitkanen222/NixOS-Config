# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
# https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
{ lib, ... }: {
  imports = [ ../../../desknix/users/mp/hyprland.nix ];

  home-manager.users.mp = {
    wayland.windowManager.hyprland.settings = {
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
