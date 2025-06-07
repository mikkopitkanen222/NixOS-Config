# Configure udisks2, a DBus service to manipulate storage devices.
#
# This module can be imported by system "main" config.
{ ... }:
{
  services.udisks2.enable = true;
}
