# Configure spotify-player, a TUI Spotify client.
# https://github.com/aome510/spotify-player
#
# This module can be imported by user "mp" config.
{ ... }:
{
  programs.spotify-player = {
    enable = true;
  };
}
