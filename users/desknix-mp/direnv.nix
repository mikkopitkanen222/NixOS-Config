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
