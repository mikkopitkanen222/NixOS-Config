# Configure Hyprland.
# https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
#
# This module can be imported by user "mp" config.
{ pkgs, ... }:
{
  # Launch Hyprland upon login in tty; There is no display manager.
  programs.bash.profileExtra = ''
    if uwsm check may-start; then
      exec uwsm start hyprland-uwsm.desktop
    fi
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    # Use the packages from the NixOS module.
    package = null;
    portalPackage = null;
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    hyprls
    hyprpicker
    hyprsysteminfo
    xdg-desktop-portal-gtk
  ];

  imports = [
    # Monitors are configured in hosts.
    ./hypridle.nix
    ./hyprlock.nix
    ./input.nix
    ./keybinds.nix
    ./look-feel.nix
    ./permissions.nix
    ./qt-support.nix
    ./tofi.nix
    ./waybar.nix
    ./workspaces.nix
  ];
}
