# nixos-config/users/desknix-mp/thunderbird.nix
# Configure Thunderbird for user 'mp' on host 'desknix'.
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
