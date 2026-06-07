# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
# https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
{ lib, ... }: {
  imports = [ ../../../desknix/users/mp/hyprland.nix ];

  home-manager.users.mp = {
    wayland.windowManager.hyprland.settings = {
      # https://wiki.hypr.land/Configuring/Workspace-Rules/
      workspace = lib.mkForce [
        "1, monitor:desc:AU Optronics 0x4A99, persistent:true, default:true"
        "10, monitor:desc:AU Optronics 0x4A99, persistent:true, layout:scrolling"
      ];
    };
  };
}
