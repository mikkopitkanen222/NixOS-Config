# nixos-config/users/desknix-mp/direnv.nix
# Configure Direnv for user 'mp' on host 'desknix'.
# https://github.com/nix-community/nix-direnv
{ ... }:
{
  home-manager.users.mp = {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
