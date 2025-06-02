# Configure a Bluetooth client.
{ pkgs, ... }:
{
  # Make sure bluetooth.service is enabled / starts at boot.
  systemd.services.bluetooth.wantedBy = [ "multi-user.target" ];

  # https://github.com/kaii-lb/overskride
  environment.systemPackages = [ pkgs.overskride ]; # <-- This can be moved to user?
}
