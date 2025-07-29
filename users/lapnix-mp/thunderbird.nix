# nixos-config/users/lapnix-mp/thunderbird.nix
# Configure Thunderbird for user 'mp' on host 'lapnix'.
{ ... }:
{
  home-manager.users.mp = {
    programs.thunderbird = {
      enable = true;
      profiles.mp = {
        isDefault = true;
      };
    };
  };
}
