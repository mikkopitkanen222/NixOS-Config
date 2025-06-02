# Configure overskride, a Bluetooth client.
# https://github.com/kaii-lb/overskride
#
# This module can be imported by system "main" config.
{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.overskride ];

  # Make sure bluetooth.service is enabled / starts at boot.
  systemd.services.bluetooth.wantedBy = [ "multi-user.target" ];
}
