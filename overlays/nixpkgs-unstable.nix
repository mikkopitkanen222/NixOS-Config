# nixos-config/overlays/nixpkgs-unstable.nix
# Overlay packages from branch nixpkgs-unstable to pkgs.unstable.
{ inputs, ... }:
final: prev: {
  unstable = import inputs.nixpkgs-unstable {
    inherit (prev) system;
    config.allowUnfree = true;
  };
}
