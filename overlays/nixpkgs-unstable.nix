# Overlay a more recent nixpkgs branch as 'pkgs.unstable'.
{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      unstable = inputs.nixpkgs-unstable.legacyPackages.${prev.system};
    })
  ];
}
