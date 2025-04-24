# Configuration for user module "calculator".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options = {
      calculator = {
        enable = lib.mkEnableOption "calculator";

        package = lib.mkPackageOption pkgs "calculator" { default = [ "qalculate-qt" ]; };
      };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.calculator;
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
