# nixos-config/overlays/default.nix
# Import overlays.
{ ... }:
{
  spotify-player-fix = import ./spotify-player-fix.nix { };
}
