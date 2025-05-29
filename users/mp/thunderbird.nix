# Configure Thunderbird.
#
# This module can be imported by user "mp" config.
{ ... }:
{
  programs.thunderbird = {
    enable = true;
    profiles.mp = {
      isDefault = true;
    };
  };
}
