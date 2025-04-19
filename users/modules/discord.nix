# Configuration for user module "discord".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options.discord = {
      enable = lib.mkEnableOption "discord";

      package = lib.mkPackageOption pkgs "discord" { default = [ "vesktop" ]; };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.discord;
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
