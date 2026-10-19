# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.hyprland;
in
{
  options.mp222.hyprland = {
    enable = lib.mkEnableOption "Hyprland";

    monitors = lib.mkOption {
      # https://wiki.hypr.land/0.54.0/Configuring/Monitors/
      type = lib.types.listOf (lib.types.attrsOf lib.types.anything);
      default = [ ];
      description = "monitorv2 entries. A catch-all entry for extra monitors is appended.";
    };

    workspaces = lib.mkOption {
      # https://wiki.hypr.land/0.54.0/Configuring/Workspace-Rules/
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Workspace rules.";
    };
  };

  config = lib.mkIf cfg.enable {
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
        package = hyprPkgs.hyprland;
        portalPackage = hyprPkgs.xdg-desktop-portal-hyprland;
        withUWSM = true;
      };

    hardware.graphics =
      let
        hyprNixpkgs =
          inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        package = hyprNixpkgs.mesa;
        package32 = hyprNixpkgs.pkgsi686Linux.mesa;
      };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
