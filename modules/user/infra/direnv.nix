# https://github.com/nix-community/nix-direnv
{ config, lib, ... }:
let
  cfg = config.mp222.direnv;
in
{
  options.mp222.direnv = {
    enable = lib.mkEnableOption "direnv";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
