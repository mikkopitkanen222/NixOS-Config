# Configuration for user module "gimp".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options = {
      gimp = {
        enable = lib.mkEnableOption "gimp";

        package = lib.mkPackageOption pkgs "gimp" { };
      };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.gimp;
    in
    lib.mkIf module.enable { home.packages = [ module.package ]; };

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
