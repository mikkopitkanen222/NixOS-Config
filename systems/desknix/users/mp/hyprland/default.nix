# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
# https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
{ lib, pkgs, ... }:
{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./input.nix
    ./keybinds.nix
    ./look-feel.nix
    ./monitors.nix
  ];

  programs.hyprland = {
    enable = true;
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
      ecosystem.enforce_permissions = "true";
      permission = [
        "${lib.getExe pkgs.hyprpicker}, screencopy, allow"
        "${lib.getExe pkgs.xdg-desktop-portal-hyprland}, screencopy, allow"
        "${lib.getExe pkgs.hyprlock}, screencopy, allow"
      ];
      windowrule = [
        # Ignore maximize requests from apps.
        "suppressevent maximize, class:.*"
        # Fix some dragging issues with XWayland.
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };
}
