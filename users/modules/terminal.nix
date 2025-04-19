# Configuration for user module "terminal".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options.terminal = {
      enable = lib.mkEnableOption "terminal";

      package = lib.mkPackageOption pkgs "terminal" { default = [ "kitty" ]; };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.terminal;
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
