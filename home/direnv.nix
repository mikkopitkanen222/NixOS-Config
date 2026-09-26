# https://github.com/nix-community/nix-direnv
{ config, lib, ... }:
let
  cfg = config.mp222.clipse;
in
{
  home-manager.users.mp = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
