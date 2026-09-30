# https://github.com/aristocratos/btop
{ lib, ... }: {
  imports = [ ../../../lapnix/users/mp/btop.nix ];

  home-manager.users.mp.programs.btop.settings.cpu_sensor =
    lib.mkForce "coretemp/Package id 0";
}
