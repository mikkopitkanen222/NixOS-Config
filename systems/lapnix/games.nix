# Configure games and game lauchers.
#
# This module can be imported by system "lapnix" config.
{ ... }:
{
  programs.steam.enable = true;

  unfree.allowedPackages = [
    "steam"
    "steam-unwrapped"
  ];
}
