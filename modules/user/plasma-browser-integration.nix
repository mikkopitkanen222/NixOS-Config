# Configuration for user module "plasma-browser-integration".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options = {
      plasma-browser-integration = {
        enable = lib.mkEnableOption "plasma-browser-integration";

        package = lib.mkPackageOption pkgs [ "kdePackages" "plasma-browser-integration" ] { };
      };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.plasma-browser-integration;
    in
    lib.mkIf module.enable {
      programs.chromium.extensions = [ "cimiefiiaegbelhefglklhhakcgmhkai" ];
      home.packages = [ module.package ];
    };

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
