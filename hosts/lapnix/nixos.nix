{ lib, ... }: {
  imports = [ ../desknix/nixos.nix ];

  programs.nh.clean = {
    dates = lib.mkForce "weekly";
    extraArgs = lib.mkForce "--keep-since 14d";
  };
}
