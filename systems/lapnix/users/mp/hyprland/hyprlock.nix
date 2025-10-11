# https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/
{ ... }:
{
  imports = [ ../../../../desknix/users/mp/hyprland/hyprlock.nix ];

  home-manager.users.mp.programs.hyprlock.settings.auth.fingerprint.enabled =
    "true";
}
