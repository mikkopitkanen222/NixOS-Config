# nixos-config/users/lapnix-mp/spotify-player.nix
# Configure spotify-player for user 'mp' on host 'lapnix'.
# https://github.com/aome510/spotify-player
{ ... }:
{
  home-manager.users.mp = {
    programs.spotify-player = {
      enable = true;
    };
  };
}
