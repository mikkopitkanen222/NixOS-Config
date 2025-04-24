# Configuration for user module "osrs".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options = {
      osrs = {
        enable = lib.mkEnableOption "osrs";

        package = lib.mkPackageOption pkgs "osrs" { default = [ "bolt-launcher" ]; };
      };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.osrs;
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
