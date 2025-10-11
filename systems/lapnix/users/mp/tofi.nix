# https://github.com/philj56/tofi
{ lib, ... }:
{
  imports = [ ../../../desknix/users/mp/tofi.nix ];

  home-manager.users.mp.programs.tofi.settings = {
    font-size = lib.mkForce 18;
    width = lib.mkForce 480;
    height = lib.mkForce 360;
  };
}
