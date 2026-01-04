# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
# https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
{ lib, pkgs, ... }:
{
  imports = [
    ../../../../desknix/users/mp/hyprland/hypridle.nix
    ./hyprlock.nix
    ../../../../desknix/users/mp/hyprland/hyprpaper.nix
    ./input.nix
    ../../../../desknix/users/mp/hyprland/keybinds.nix
    ../../../../desknix/users/mp/hyprland/look-feel.nix
    ./monitors.nix
  ];

  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    withUWSM = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  home-manager.users.mp = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      # Use the packages from the NixOS module.
      package = null;
      portalPackage = null;
    };

    home.sessionVariables.NIXOS_OZONE_WL = "1";

    home.packages = with pkgs; [
      hyprland-qt-support
      hyprland-qtutils
      hyprls
      hyprpicker
      hyprsysteminfo
      xdg-desktop-portal-gtk
    ];

    services.hyprpolkitagent.enable = true;

    wayland.windowManager.hyprland.settings = {
      misc.disable_watchdog_warning = true;
      ecosystem.enforce_permissions = "true";
      permission = [
        "${lib.getExe pkgs.hyprlock}, screencopy, allow"
        "${lib.getExe pkgs.hyprpicker}, screencopy, allow"
        "${lib.getExe pkgs.xdg-desktop-portal-hyprland}, screencopy, allow"
      ];
      windowrule = [
        {
          name = "ignore-maximize-requests";
          "match:class" = ".*";
          suppress_event = "maximize";
        }
        {
          name = "fix-xwayland-drag";
          "match:class" = "^$";
          "match:title" = "^$";
          "match:xwayland" = 1;
          "match:float" = 1;
          "match:fullscreen" = 0;
          "match:pin" = 0;
          no_focus = "on";
        }
      ];
    };
  };
}
