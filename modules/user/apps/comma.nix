# https://github.com/nix-community/comma
{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.mp222.comma;
in
{
  imports = [ inputs.nix-index-database.homeModules.default ];

  options.mp222.comma = {
    enable = lib.mkEnableOption "comma";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-index-database.comma.enable = true;
  };
}
