# nixos-config/overlays/default.nix
# Import overlays.
{ inputs, ... }:
{
  nixpkgs-unstable = import ./nixpkgs-unstable.nix { inherit inputs; };
}
