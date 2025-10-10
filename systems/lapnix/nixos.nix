{ lib, ... }:
{
  imports = [ ../desknix/nixos.nix ];

  nix.gc = {
    dates = lib.mkForce "weekly";
    options = lib.mkForce "--delete-older-than 14d";
  };
}
