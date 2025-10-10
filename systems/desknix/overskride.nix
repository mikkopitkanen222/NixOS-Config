# nixos-config/systems/desknix/overskride.nix
# Configure overskride on host 'desknix'.
# https://github.com/kaii-lb/overskride
{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.overskride ];

  # Make sure bluetooth.service is enabled / starts at boot.
  systemd.services.bluetooth.wantedBy = [ "multi-user.target" ];
}
