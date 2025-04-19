# Configuration for user module "shotcut".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options.shotcut = {
      enable = lib.mkEnableOption "shotcut";
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.shotcut;
    in
    lib.mkIf module.enable { home.packages = [ pkgs.shotcut ]; };

  cfg = config.build.user;
in
{
  options = {
    build.user = lib.mkOption { type = lib.types.attrsOf (lib.types.submodule moduleOptions); };
  };

  config = {
    home-manager.users = builtins.mapAttrs (moduleConfig) cfg;
  };
}
