# Configure Hyprland permissions.
# https://wiki.hyprland.org/Configuring/Permissions/
# https://wiki.hyprland.org/Hypr-Ecosystem/hyprpolkitagent/
#
# This module can be imported by user "mp" Hyprland config.
{ config, pkgs, ... }:
{
  # Create and enable a systemd service. Does not install the package!
  services.hyprpolkitagent.enable = true;

  home.packages = [
    pkgs.hyprland-qtutils
    config.services.hyprpolkitagent.package
  ];

  wayland.windowManager.hyprland.settings = {
    ecosystem.enforce_permissions = "true";
    permission = [
      "${pkgs.xdg-desktop-portal-hyprland}/lib/xdg-desktop-portal-hyprland, screencopy, allow"
    ];
  };
}
