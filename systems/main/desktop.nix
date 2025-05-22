# Install Hyprland. Configuration done in user config.
# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
#
# This module can be imported by system "main" config.
{ inputs, pkgs, ... }:
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
}
