# https://github.com/aristocratos/btop
{ lib, pkgs, ... }:
{
  imports = [ ../../../desknix/users/mp/btop.nix ];

  home-manager.users.mp.programs.btop = {
    package = lib.mkForce pkgs.btop;
    settings = {
      shown_boxes = lib.mkForce "cpu mem net proc";
      update_ms = lib.mkForce 2500;
      custom_gpu_name0 = lib.mkForce "";
    };
  };
}
