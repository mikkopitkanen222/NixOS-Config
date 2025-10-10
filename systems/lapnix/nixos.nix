# nixos-config/systems/lapnix/nixos.nix
# Configure Nix and NixOS on host 'lapnix'.
{ lib, ... }:
{
  imports = [ ../desknix/nixos.nix ];

  nix.gc = lib.mkForce {
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}
