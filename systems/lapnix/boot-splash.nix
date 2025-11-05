{ lib, ... }:
{
  imports = [ ../desknix/boot-splash.nix ];

  boot.initrd.systemd.enable = lib.mkForce false;
}
