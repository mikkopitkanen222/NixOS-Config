# Configuration for user module "whatsapp".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options = {
      whatsapp = {
        enable = lib.mkEnableOption "whatsapp";

        package = lib.mkPackageOption pkgs "whatsapp" { default = [ "whatsie" ]; };
      };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.whatsapp;
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
