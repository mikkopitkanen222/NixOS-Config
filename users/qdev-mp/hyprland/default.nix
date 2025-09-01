# nixos-config/users/qdev-mp/hyprland/default.nix
# Install Hyprland on system level and configure it for user 'mp' on host 'qdev'.
# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
# https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  # Hyprland flake is not built by Hydra, so it is not cached as usual.
  # Enable Hyprland Cachix to avoid having to compile Hyprland ourselves.
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  programs.hyprland =
    let
      hyprPkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      withUWSM = true;
      # Package and portalPackage must be in sync.
      package = hyprPkgs.hyprland;
      portalPackage = hyprPkgs.xdg-desktop-portal-hyprland;
    };

  # Make sure to use the same version of Mesa as Hyprland does
  # to avoid performance problems.
  hardware.graphics =
    let
      hyprlandPkgs =
        inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      package = hyprlandPkgs.mesa;
      package32 = hyprlandPkgs.pkgsi686Linux.mesa;
    };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  home-manager.users.mp = {
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

  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./input.nix
    ./keybinds.nix
    ./look-feel.nix
    ./monitors.nix
  ];
}
