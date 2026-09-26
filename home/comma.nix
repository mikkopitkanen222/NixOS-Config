{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.mp222.clipse;
in
{
  home-manager.users.mp = {
    imports = [ inputs.nix-index-database.homeModules.default ];
    programs.nix-index-database.comma.enable = true;
  };
}
