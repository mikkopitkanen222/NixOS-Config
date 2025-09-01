# nixos-config/systems/qdev-work/overskride.nix
# Configure overskride for system 'work' on host 'qdev'.
# https://github.com/kaii-lb/overskride
{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.overskride ];

  # Make sure bluetooth.service is enabled / starts at boot.
  systemd.services.bluetooth.wantedBy = [ "multi-user.target" ];
}
